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
        rospy.Subscriber("movement_plan_request", fdm_msgs.msg.GCodeCommand, self.toolpathPlanner.robotPosition)
        rospy.Subscriber("movement_execution", fdm_msgs.msg.MovementPlanConsec, self.toolpathPlanner.executePlan)

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
        self.move_group.set_max_acceleration_scaling_factor(0.05)

        # initialize "Home" position robotic arm, in frame 'buildPlate'
        self.pose_goal = geometry_msgs.msg.Pose()
        self.pose_goal.position.x = 0.2620
        self.pose_goal.position.y = 0.1636
        self.pose_goal.position.z = 0.2228
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

        self.goToHome()
        self.movementPlanMSG = fdm_msgs.msg.MovementPlan()

        self.display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        self.display_trajectory.trajectory_start = self.robot.get_current_state()

        return
    
    def goToHome(self):
        self.joint_state.position = [1.5708, -1.5708, 1.5708, 4.7124, 4.7124, 0]
        self.move_group.go(copy.deepcopy(self.joint_state))
        self.move_group.stop()
        return

    def robotPosition(self, cmd):
        if cmd.is_final:
            self.showPlan()
            return
        if not math.isnan(cmd.f):
            self.move_group.limit_max_cartesian_link_speed(cmd.f * 1.66666667e-5, link_name='tcp')
        if not math.isnan(cmd.x):
            self.pose_goal.position.x = cmd.x * 0.001
        if not math.isnan(cmd.y):
            self.pose_goal.position.y = cmd.y * 0.001
        if not math.isnan(cmd.z):
            self.pose_goal.position.z = cmd.z * 0.001
        if not math.isnan(cmd.b):
            self.quaternion = quaternion_from_euler(pi, cmd.b, pi)
            # print(f'The received b value is: {cmd.b}')
            self.pose_goal.orientation.x = self.quaternion[0]
            self.pose_goal.orientation.y = self.quaternion[1]
            self.pose_goal.orientation.z = self.quaternion[2]
            self.pose_goal.orientation.w = self.quaternion[3]
            # print(f'Which gives this orientation: {self.pose_goal.orientation}')

        self.movementPlanMSG.seq_id = cmd.seq_id
        self.computePlanPose()
        return

    def computePlanPose(self):
        (self.plan, self.fraction) = self.move_group.compute_cartesian_path(
                                       [copy.deepcopy(self.pose_goal)],
                                       0.0005,
                                       False)
        self.movementPlanMSG.trajectory = self.plan
        self.movementPlanMSG.execution_time = self.plan.joint_trajectory.points[-1].time_from_start
        self.comms.publish_toolpath_plan(self.movementPlanMSG)
        self.setStartState()
        return
        
    def setStartState(self):
        self.latest_joint_positions = copy.deepcopy(self.plan).joint_trajectory.points[-1].positions
        self.joint_state.position = copy.deepcopy(self.latest_joint_positions)
        self.robot_state.joint_state = copy.deepcopy(self.joint_state)
        self.move_group.set_start_state(copy.deepcopy(self.robot_state))
        self.trajectory_list.append(copy.deepcopy(self.plan))
        return

    def showPlan(self):
        print(f'Displaying trajectory of {len(self.trajectory_list)} sub-points!')

        for plan in self.trajectory_list:
            self.display_trajectory.trajectory.append(plan)

        self.comms.display_trajectory_publisher.publish(self.display_trajectory)
        return

    def executePlan(self, mvmPlan):
        if not mvmPlan.trajectory:
            print("No trajectory to execute!")
            return
        if mvmPlan.seq_ids[0] == -1:
            self.goToHome()
            return
        
        self.move_group.execute(mvmPlan.trajectory, wait=True)
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