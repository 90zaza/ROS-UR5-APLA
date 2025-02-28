#!/usr/bin/env python

import rospy
import fdm_msgs.msg
import sys
import os

class Communication:
    def __init__(self):
        self.gcodeInterpreter = None
        self.toolpathPlanner = None

        self.gcode_publisher = rospy.Publisher('/gcode_raw', fdm_msgs.msg.GCode, queue_size=10)
        self.movementPlanRequest_publisher = rospy.Publisher('/movement_plan_request', fdm_msgs.msg.GCodeCommand, queue_size=10)

    def set_class_pointers(self, gcodeInterpreter, toolpathPlanner):
        self.gcodeInterpreter = gcodeInterpreter
        self.toolpathPlanner = toolpathPlanner

        return
    
    def set_subscribers(self):
        rospy.Subscriber("gcode_command", fdm_msgs.msg.GCodeCommand, self.toolpathPlanner.gcodeCommands)

        return

    def wait_for_publishers(self):        
        while (self.gcode_publisher.get_num_connections()) == 0: # and self.movementPlanRequest_publisher.get_num_connections()) == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'gcode_raw' and 'movement_plan_request'...")
            rospy.sleep(1)

        rospy.sleep(2)
        rospy.loginfo("Communication initialized for main.py.")

        return

    def publish_gcode_raw(self, lines):
        gcode_msg = fdm_msgs.msg.GCode()
        gcode_msg.lines = lines
        self.gcode_publisher.publish(gcode_msg)
        rospy.sleep(0.01)

    def publish_movement_plan_request(self, cmd):
        self.movementPlanRequest_publisher.publish(cmd)
        rospy.sleep(0.01)


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
    def __init__(self, comms):
        self.comms = comms
        self.gcodeCommandList = []

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
        print(self.consecutiveMovementSequence(movementCommands))

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
    gcodeInterpreter = GCodeInterpreter(gcode_path, comms)
    toolpathPlanner = ToolpathPlanner(comms)
    
    comms.set_class_pointers(gcodeInterpreter, toolpathPlanner)
    comms.set_subscribers()
    comms.wait_for_publishers()
    
    gcodeInterpreter.parser()

    rospy.spin()

if __name__ == '__main__':
    main()