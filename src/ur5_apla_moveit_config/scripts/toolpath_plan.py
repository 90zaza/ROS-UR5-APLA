#!/usr/bin/env python
import rospy
import copy
import json
import math
import std_msgs.msg
import fdm_msgs.msg
import moveit_msgs.msg
import sensor_msgs.msg
import geometry_msgs.msg
import moveit_commander as mc
from math import pi
from std_msgs.msg import String
from tf.transformations import quaternion_from_euler

class Communication:
    def __init__(self):
        self.toolpathPlanner = None

        self.display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                            moveit_msgs.msg.DisplayTrajectory,
                                            queue_size=20)
        self.movementPlanResponse_publisher = rospy.Publisher('/movement_plan_response', fdm_msgs.msg.MovementPlan, queue_size=10)

    def set_class_pointers(self, toolpathPlanner):
        self.toolpathPlanner = toolpathPlanner

        return
    
    def set_subscribers(self):
        rospy.Subscriber("movement_plan_request", fdm_msgs.msg.GCodeCommand, self.toolpathPlanner.robotPosition())

        return
    
    def wait_for_publishers(self):
        while self.movementPlanResponse_publisher.get_num_connections() == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'movement_plan_response'...")
            rospy.sleep(1)

        rospy.sleep(2)
        rospy.loginfo("Communication initialized for toolpath_plan.py.")

        return
    
    def publish_toolpath_plan(self, command):
        self.movementPlanResponse_publisher.publish(command)
        rospy.sleep(0.01)

        return
    
class ToolpathPlanner:
    def __init__(self, communication):
        self.comms = communication
                
        self.robot = mc.RobotCommander()
        self.psi = mc.PlanningSceneInterface()
        self.move_group = mc.MoveGroupCommander('manipulator')

        self.move_group.set_pose_reference_frame('buildPlate')
        self.move_group.limit_max_cartesian_link_speed(0.3, link_name='tcp')
        self.move_group.set_max_acceleration_scaling_factor(0.1)

        # initialize standard position robotic arm
        self.pose_goal = geometry_msgs.msg.Pose()
        self.pose_goal.position.x = 0
        self.pose_goal.position.y = 0
        self.pose_goal.position.z = 0.2
        self.quaternion = quaternion_from_euler(pi, 0, pi)
        self.pose_goal.orientation.x = self.quaternion[0]
        self.pose_goal.orientation.y = self.quaternion[1]
        self.pose_goal.orientation.z = self.quaternion[2]
        self.pose_goal.orientation.w = self.quaternion[3]

        self.joint_state = sensor_msgs.msg.JointState()
        self.robot_state = moveit_msgs.msg.RobotState()

        self.joint_state.header = std_msgs.msg.Header()
        self.joint_state.header.stamp = rospy.Time.now()
        self.joint_state.name = ['shoulder_pan_joint',
                            'shoulder_lift_joint',
                            'elbow_joint',
                            'wrist_1_joint',
                            'wrist_2_joint',
                            'wrist_3_joint']
        #This is the home position
        self.joint_state.position = [1.5708,
                            -1.5708,
                            1.5708,
                            4.7124,
                            4.7124,
                            0]

        self.trajectory_list = []
        self.last_time = rospy.Duration(0)

        self.display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        self.display_trajectory.trajectory_start = self.robot.get_current_state()

        return

    def robotPosition(self, cmd):
        if cmd.is_final:
            self.showPlan()
        if cmd["movement"]["f"] is not math.nan:
            self.move_group.limit_max_cartesian_link_speed(data["movement"]["f"] * 1.66666667e-5, link_name='tcp')

        if cmd["movement"]["x"] is not math.nan:
            self.pose_goal.position.x = data["movement"]["x"] * 0.001
        
        if cmd["movement"]["y"] is not math.nan:
            self.pose_goal.position.y = data["movement"]["y"] * 0.001

        if cmd["movement"]["z"] is not math.nan:
            self.pose_goal.position.z = data["movement"]["z"] * 0.001
    
        
        else:
            self.computePlan()
        return
    
    def computePlanJoint(self):
        (self.success, self.plan, self.time, self.error) = self.move_group.plan(self.joint_state)
        self.setStartState()
        return

    def computePlanPose(self):
        (self.plan, self.fraction) = self.move_group.compute_cartesian_path(
                                       [copy.deepcopy(self.pose_goal)],
                                       0.01,
                                       False)
        self.setStartState()
        return
        
    def setStartState(self):
        self.latest_joint_positions = copy.deepcopy(self.plan).joint_trajectory.points[-1].positions
        self.joint_state.position = copy.deepcopy(self.latest_joint_positions)
        self.robot_state.joint_state = copy.deepcopy(self.joint_state)
        self.move_group.set_start_state(copy.deepcopy(self.robot_state))
        
        for point in self.plan.joint_trajectory.points:
            if point.time_from_start.to_sec() == 0:
                point.time_from_start += rospy.Duration(nsecs=1)
            point.time_from_start += self.last_time
        
        self.last_time = self.plan.joint_trajectory.points[-1].time_from_start
        self.trajectory_list.append(copy.deepcopy(self.plan))

    def showPlan(self):
        print('Displaying trajectory!')
        print(len(self.trajectory_list))

        for plan in self.trajectory_list:
            self.display_trajectory.trajectory.append(plan)

        print(self.display_trajectory)
        self.display_trajectory_publisher.publish(self.display_trajectory)

        input("Press Enter to execute the trajectory...")
        self.executePlan()

    def executePlan(self):
        if not self.trajectory_list:
            print("No trajectory to execute!")
            return
        
        full_trajectory = moveit_msgs.msg.RobotTrajectory()
        for plan in self.trajectory_list:
            full_trajectory.joint_trajectory.points.extend(plan.joint_trajectory.points)
            if not full_trajectory.joint_trajectory.joint_names:
                full_trajectory.joint_trajectory.joint_names = plan.joint_trajectory.joint_names
        
        self.move_group.execute(full_trajectory, wait=True)
        print("Trajectory execution completed!")


def main():
    rospy.init_node('toolpathPlan', anonymous=True)

    comms = Communication()
    toolpathPlanner = ToolpathPlanner(comms)

    comms.set_class_pointers(toolpathPlanner)
    comms.set_subscribers()
    comms.wait_for_publishers()

    rospy.spin()

if __name__ == '__main__':
    main()