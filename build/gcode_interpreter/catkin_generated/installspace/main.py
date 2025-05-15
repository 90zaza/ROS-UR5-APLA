#!/usr/bin/env python3

import rospy
import moveit_msgs.msg
import std_msgs.msg
import fdm_msgs.msg
import sys
import os
import math
import threading

class Communication:
    def __init__(self):
        self.gcodeInterpreter = None
        self.toolpathPlanner = None
        self.executer = None

        self.gcode_publisher = rospy.Publisher('/gcode_raw', fdm_msgs.msg.GCode, queue_size=10)
        self.movementPlanRequest_publisher = rospy.Publisher('/movement_plan_request', fdm_msgs.msg.GCodeCommand, queue_size=10)
        self.movementPlanExecution_publisher = rospy.Publisher('/movement_execution', fdm_msgs.msg.MovementPlanConsec, queue_size=10)
        self.duetRequest_publisher = rospy.Publisher('/duet_request', fdm_msgs.msg.GCodeCommand, queue_size=10)

    def set_class_pointers(self, gcodeInterpreter, toolpathPlanner, executer):
        self.gcodeInterpreter = gcodeInterpreter
        self.toolpathPlanner = toolpathPlanner
        self.executer = executer

        return
    
    def set_subscribers(self):
        rospy.Subscriber("gcode_command", fdm_msgs.msg.GCodeCommand, self.toolpathPlanner.gcodeCommands)
        rospy.Subscriber("movement_plan_response", fdm_msgs.msg.MovementPlan, self.toolpathPlanner.movementPlanConcatenater)
        rospy.Subscriber("duet_response", std_msgs.msg.String, self.executer.receivedCommand)
        rospy.Subscriber("execute_trajectory/feedback", moveit_msgs.msg.ExecuteTrajectoryActionFeedback, self.executer.receivedStartingTime)

        return

    def wait_for_publishers(self):        
        while (self.gcode_publisher.get_num_connections() and 
               self.movementPlanRequest_publisher.get_num_connections() and
               self.duetRequest_publisher.get_num_connections()) == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'gcode_raw', 'movement_plan_request' and 'duet_request'...")
            rospy.sleep(1)

        rospy.sleep(2)
        rospy.loginfo("Communication initialized for main.py.")

        return

    def publish_gcode_raw(self, lines):
        gcode_msg = fdm_msgs.msg.GCode()
        gcode_msg.lines = lines
        self.gcode_publisher.publish(gcode_msg)
        rospy.sleep(0.01)

        return

    def publish_movement_plan_request(self, cmd):
        self.movementPlanRequest_publisher.publish(cmd)
        rospy.sleep(0.01)

        return

    def publish_movement_execution(self, cmd):
        self.movementPlanExecution_publisher.publish(cmd)

        return
    
    def publish_duet_request(self, cmd):
        self.duetRequest_publisher.publish(cmd)

        return


class GCodeInterpreter:
    def __init__(self, file_path, comms):
        self.file_path = file_path
        self.comms = comms
        self.gCodeList = []

    def parser(self):
        with open(self.file_path, 'r') as file:
            gcode_lines = file.readlines()
              
        for line in gcode_lines:
            self.gCodeList.append(line.strip())

        self.comms.publish_gcode_raw(self.gCodeList)
        rospy.loginfo("Finished parsing and publishing gCode.")


class ToolpathPlanner:
    def __init__(self, executer, comms):
        self.executer = executer
        self.comms = comms
        self.gcodeCommandList = []
        self.countedMovementCommands = 0

    def gcodeCommands(self, gcodeCommand):
        self.gcodeCommandList.append(gcodeCommand)
        if not gcodeCommand.is_final:
            return

        self.gcodeCommandList.sort(key=lambda cmd: cmd.seq_id)

        # Find missing seq_ids
        expected_seq_ids = set(range(self.gcodeCommandList[0].seq_id, self.gcodeCommandList[-1].seq_id + 1))
        received_seq_ids = {cmd.seq_id for cmd in self.gcodeCommandList}
        missing_seq_ids = sorted(expected_seq_ids - received_seq_ids)

        # Print missing seq_ids if any
        if missing_seq_ids:
            print(f"Missing seq_id(s): {missing_seq_ids}")
            rospy.signal_shutdown("Missing seq_id(s)")
        print("No missing seq_id(s) detected.")

        movementCommands = self.filterMovement(self.gcodeCommandList)
        self.totalMovementCommands = len(movementCommands) - 1
        self.sequentialMovementCommands = self.consecutiveMovementSequence(movementCommands[:-1])
        self.sequentialMovementCommandsIndices = dict( (j,(x, y)) for x, i in enumerate(self.sequentialMovementCommands) for y, j in enumerate(i) )
        self.movementPlanList = [[None] * len(sublist) for sublist in self.sequentialMovementCommands]
        self.movementPlanConsecList = [None] * len(self.sequentialMovementCommands)

        print(f'{self.sequentialMovementCommands}\n')

        for cmd in movementCommands:
            self.comms.publish_movement_plan_request(cmd)

        return

    def filterMovement(self, gcodeCommandList):
        return [cmd for cmd in gcodeCommandList if cmd.has_movement]

    def consecutiveMovementSequence(self, movementCommands):
        grouped_seq_ids = []
        current_group = []

        for i, cmd in enumerate(movementCommands):
            if not current_group:
                current_group.append(cmd.seq_id)
            else:
                prev_cmd = movementCommands[i - 1]
                if cmd.seq_id == prev_cmd.seq_id + 1:
                    current_group.append(cmd.seq_id)
                else:
                    grouped_seq_ids.append(current_group)  # Store previous group
                    current_group = [cmd.seq_id]  # Start a new group

        if current_group:
            grouped_seq_ids.append(current_group)

        return grouped_seq_ids
    
    def calculateGCodeExtrusionTime(self):
        cmdCounter = 0
        mvmCounter = 0
        while cmdCounter < len(self.gcodeCommandList):
            if self.gcodeCommandList[cmdCounter].is_final:
                return
            if self.gcodeCommandList[cmdCounter].has_movement:
                for i in range(len(self.movementPlanConsecList[mvmCounter].timestamps)):
                    if i == 0:
                        exec_time = self.movementPlanConsecList[mvmCounter].timestamps[i]
                    else:
                        exec_time = self.movementPlanConsecList[mvmCounter].timestamps[i] - self.movementPlanConsecList[mvmCounter].timestamps[i-1]
                    if self.gcodeCommandList[cmdCounter].has_extrusion:
                        exec_time_mins = exec_time.to_sec() / 60
                        # print(f'exec_time: {exec_time}, exec_time_mins: {exec_time_mins}, i: {i}, timestamps[i]: {self.movementPlanConsecList[mvmCounter].timestamps[i]}')
                        # print(f'gCode: {self.gcodeCommandList[cmdCounter]}')
                        f = abs(self.gcodeCommandList[cmdCounter].e / exec_time_mins)
                        cmd = f"G1 F{f:.5f} E{self.gcodeCommandList[cmdCounter].e:.5f}"
                        self.gcodeCommandList[cmdCounter].printing_command = cmd
                    cmdCounter += 1
                mvmCounter += 1
            cmdCounter += 1
        return

    
    def movementPlanConcatenater(self, movementPlan):
        self.countedMovementCommands += 1
        index = self.sequentialMovementCommandsIndices[movementPlan.seq_id]
        self.movementPlanList[index[0]][index[1]] = movementPlan
        last_time = None

        if not None in self.movementPlanList[index[0]]:
            self.movementPlanConsecList[index[0]] = fdm_msgs.msg.MovementPlanConsec()
            last_time = self.movementPlanList[index[0]][0].trajectory.joint_trajectory.points[-1].time_from_start
            self.movementPlanConsecList[index[0]].timestamps.append(last_time)
            self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.points.extend(self.movementPlanList[index[0]][0].trajectory.joint_trajectory.points)
            if not self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.joint_names:
                self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.joint_names = self.movementPlanList[index[0]][0].trajectory.joint_trajectory.joint_names
            for mvmPlan in self.movementPlanList[index[0]][1:]:
                for point in mvmPlan.trajectory.joint_trajectory.points:
                    # if point.time_from_start.to_sec() == 0:
                    #     point.time_from_start += rospy.Duration(nsecs=1)
                    point.time_from_start += last_time
                last_time = mvmPlan.trajectory.joint_trajectory.points[-1].time_from_start
                self.movementPlanConsecList[index[0]].timestamps.append(last_time)
                self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.points.extend(mvmPlan.trajectory.joint_trajectory.points[1:])
                # self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.points.extend(mvmPlan.trajectory.joint_trajectory.points)
                if not self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.joint_names:
                    self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.joint_names = mvmPlan.trajectory.joint_trajectory.joint_names
            # last_time = self.movementPlanList[index[0]][-1].trajectory.joint_trajectory.points[-1].time_from_start
            # self.movementPlanConsecList[index[0]].timestamps[-1] = last_time
            # self.movementPlanConsecList[index[0]].trajectory.joint_trajectory.points.extend(self.movementPlanList[index[0]][-1].trajectory.joint_trajectory.points[-1:])
            self.movementPlanConsecList[index[0]].seq_ids = self.sequentialMovementCommands[index[0]]

        if self.totalMovementCommands == self.countedMovementCommands:
            self.calculateGCodeExtrusionTime()

            input("Everything seems to be ready for execution, press Enter to continue.")
            self.executer.mainLoop(self.gcodeCommandList, self.movementPlanConsecList)
        return

class Executer:
    def __init__(self, comms):
        self.comms = comms
        self.response_event = threading.Event()
        self.latest_response = None
        self.startingTime = None
        self.receivedNewStartingTime = False

    def mainLoop(self, gcodeCommandList, movementPlanList):
        cmdCounter = 0
        mvmCounter = 0
        while cmdCounter < len(gcodeCommandList):
            if gcodeCommandList[cmdCounter].is_final:
                print(f"I should be at the end, sending UR5 to Home")
                finalCMD = fdm_msgs.msg.MovementPlanConsec()
                finalCMD.seq_ids = [-1]
                self.comms.publish_movement_execution(finalCMD)
                return
            if gcodeCommandList[cmdCounter].has_movement:
                print(f'Executing movementPlanList[{mvmCounter}]')
                self.comms.publish_movement_execution(movementPlanList[mvmCounter])
                # startOfMovement = rospy.get_rostime()

                for i in range(len(movementPlanList[mvmCounter].timestamps)):
                    if gcodeCommandList[cmdCounter].has_extrusion:
                        self.comms.publish_duet_request(gcodeCommandList[cmdCounter])
                        print(f'Sending gcodeCommand: {gcodeCommandList[cmdCounter].printing_command}')

                    # if i == 0:
                    #     exec_time = movementPlanList[mvmCounter].timestamps[i]
                    # else:
                    #     exec_time = movementPlanList[mvmCounter].timestamps[i] - movementPlanList[mvmCounter].timestamps[i-1]
                    
                    while self.receivedNewStartingTime == False:
                        rospy.sleep(1)

                    currentTime = rospy.get_rostime()
                    rospy.sleep(self.startingTime + movementPlanList[mvmCounter].timestamps[i] - currentTime)
                    # print(f'[{self.startingTime.secs}.{self.startingTime.nsecs}] Calculated time: {exec_time} vs. timeSlept: {self.startingTime + movementPlanList[mvmCounter].timestamps[i] - currentTime}')
                    cmdCounter += 1
                mvmCounter += 1
                self.receivedNewStartingTime = False

                # print(f'This was the total time for this movementPlanList: {movementPlanList[mvmCounter-1].timestamps[-1]}')

            print(f'Sending gcodeCommand {gcodeCommandList[cmdCounter].printing_command}')
            self.comms.publish_duet_request(gcodeCommandList[cmdCounter])
            self.waitForDuetResponse()

            cmdCounter += 1
        return
    
    def waitForDuetResponse(self, timeout=120):
        rospy.loginfo("Waiting for /duet_response message...")
        received = self.response_event.wait(timeout)  # Blocks until event is set or timeout occurs

        if received:
            self.response_event.clear()  # Reset for the next message

            if self.latest_response != "OK":  # Check the received message
                rospy.logerr(f"Unexpected response received: {self.latest_response}")
                sys.exit(1)  # Quit the script with an error code

        else:
            rospy.logwarn("Timeout while waiting for /duet_response")
            sys.exit(1)  # Quit on timeout as well

    def receivedCommand(self, msg):
        self.latest_response = msg.data  # Store the received response
        rospy.loginfo(f"Received response: {msg.data}")
        self.response_event.set()
        return
    
    def receivedStartingTime(self, msg):
        # rospy.loginfo(msg)
        if msg.status.status == 1:
            self.startingTime, self.receivedNewStartingTime = rospy.Time(msg.status.goal_id.stamp.secs, msg.status.goal_id.stamp.nsecs), True
            # self.receivedNewStartingTime = True
        # rospy.loginfo(f'Received {msg}!')
        # rospy.loginfo(f'{msg.status.goal_id.stamp.secs}.{msg.status.goal_id.stamp.nsecs} seconds')
        # rospy.loginfo(f'Status: {msg.status.status}, with type {type(msg.status.status)}')
        return


def main():
    rospy.init_node('main', anonymous=True)
    if len(sys.argv) > 1:
        gcode_path = sys.argv[1]
        if os.path.isfile(gcode_path):
            print(f"Found gCode file: {gcode_path}")
        else:
            print("Error: Provided file path does not exist.")
            return
    else:
        gcode_path = input("Please enter the path to the gCode file: ").strip()
        while not os.path.isfile(gcode_path):
            print("Invalid file path. Try again.")
            gcode_path = input("Please enter the path to the gCode file: ").strip()
    
    comms = Communication()
    executer = Executer(comms)
    gcodeInterpreter = GCodeInterpreter(gcode_path, comms)
    toolpathPlanner = ToolpathPlanner(executer, comms)
    
    comms.set_class_pointers(gcodeInterpreter, toolpathPlanner, executer)
    comms.set_subscribers()
    comms.wait_for_publishers()
    
    gcodeInterpreter.parser()

    rospy.spin()

if __name__ == '__main__':
    main()