#!/usr/bin/env python
import rospy
import copy
import json
import geometry_msgs.msg
import moveit_commander as mc
import moveit_msgs.msg
import sensor_msgs.msg
from math import pi
from std_msgs.msg import String
from tf.transformations import quaternion_from_euler

class toolpathPlan:
    def __init__(self):
        # mc.roscpp_initialize(sys.argv)
        rospy.init_node('toolpathPlan', anonymous=True)
        
        self.robot = mc.RobotCommander()
        self.psi = mc.PlanningSceneInterface()
        self.move_group = mc.MoveGroupCommander('manipulator')

        self.move_group.set_pose_reference_frame('buildPlate')
        self.move_group.limit_max_cartesian_link_speed(0.3, link_name='tcp')

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

        self.trajectory_list = []

        return
    
    def subscriber(self):
        rospy.Subscriber("gcode_movement", String, self.robotPosition)
        rospy.Subscriber("gcode_printing", String)

        rospy.spin()

        return

    def robotPosition(self, data):
        data = json.loads(data.data)
        if data:
            if data["movement"]["f"] is not None:
                self.move_group.limit_max_cartesian_link_speed(data["movement"]["f"] * 1.66666667e-5, link_name='tcp')

            if data["movement"]["x"] is not None:
                self.pose_goal.position.x = data["movement"]["x"] * 0.001
            
            if data["movement"]["y"] is not None:
                self.pose_goal.position.y = data["movement"]["y"] * 0.001

            if data["movement"]["z"] is not None:
                self.pose_goal.position.z = data["movement"]["z"] * 0.001
        
            if data["comment"] == "End of Gcode":
                self.showPlan()
            else:
                self.computePlan()
        return
    
    def computePlan(self):
        (plan, fraction) = self.move_group.compute_cartesian_path(
                                       [copy.deepcopy(self.pose_goal)],  # waypoints to follow
                                       0.01,        # eef_step
                                       False)       # jump_threshold
        
        latest_joint_positions = copy.deepcopy(plan).joint_trajectory.points[-1].positions  # Extract joint values

        self.robot_state = moveit_msgs.msg.RobotState()
        self.robot_state.joint_state = sensor_msgs.msg.JointState()
        
        self.robot_state.joint_state.name = self.move_group.get_joints()[1:7] 
        
        self.robot_state.joint_state.position = list(latest_joint_positions)
        self.move_group.set_start_state(copy.deepcopy(self.robot_state))
        
        if fraction > 0:  # Only add the plan if it is valid
            self.trajectory_list.append(copy.deepcopy(plan))

        return
    
    def showPlan(self):
        self.display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                            moveit_msgs.msg.DisplayTrajectory,
                                            queue_size=20)
        self.display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        self.display_trajectory.trajectory_start = self.robot.get_current_state()

        for plan in self.trajectory_list:
            self.display_trajectory.trajectory.append(plan)

        self.display_trajectory_publisher.publish(self.display_trajectory)

        return

if __name__ == '__main__':
    toolpathPlan = toolpathPlan()
    toolpathPlan.subscriber()