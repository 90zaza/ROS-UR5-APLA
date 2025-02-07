#!/usr/bin/env python3

import sys
import rospy
import moveit_commander as mc
import moveit_msgs.msg
import geometry_msgs.msg
import std_msgs.msg
import yaml
import copy
from math import pi
from tf.transformations import quaternion_from_euler
# from moveit_commander.robot_trajectory import RobotTrajectory
# from moveit_commander.time_parameterization import IterativeParabolicTimeParameterization

# pose_goal = geometry_msgs.msg.Pose()
# pose_goal.position.x = 0
# pose_goal.position.y = 0.4
# pose_goal.position.z = 0.002 + offset
# pose_goal.orientation.x = -1.0
# pose_goal.orientation.y = 0
# pose_goal.orientation.z = 0
# pose_goal.orientation.w = 0

def is_close(pos1, pos2, threshold=0.005):
    """Check if two positions are within a certain threshold."""
    return (abs(pos1.x - pos2.x) < threshold and 
            abs(pos1.y - pos2.y) < threshold and 
            abs(pos1.z - pos2.z) < threshold)

if __name__ == '__main__':
    mc.roscpp_initialize(sys.argv) 
    rospy.init_node("ur5_apla_toolpath", anonymous=True)
    
    robot = mc.RobotCommander()
    psi = mc.PlanningSceneInterface()
    move_group = mc.MoveGroupCommander('manipulator')

    display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                                   moveit_msgs.msg.DisplayTrajectory,
                                                   queue_size=20)

    feedback_publisher = rospy.Publisher('/ur5_publisher', std_msgs.msg.String, queue_size=10)

    with open('/home/tim/FDMPrinting/src/ur5_apla_moveit_config/config/calibration.yaml') as f:
        doc = yaml.load(f, Loader=yaml.FullLoader)

    offset = doc['calibration']['z']

    # Set movement speed (0.3 = 30% of max speed, 1.0 = 100% max speed)
    move_group.set_max_velocity_scaling_factor(0.3)  # Adjust for desired speed
    move_group.set_max_acceleration_scaling_factor(1.0)  # Fastest acceleration

    waypoints = []
    move_group.set_pose_reference_frame('buildPlate')

    # Planning a square
    # wpose = move_group.get_current_pose().pose
    # wpose.position.y += 0.2
    # waypoints.append(copy.deepcopy(wpose))

    # wpose.position.x -= 0.15
    # waypoints.append(copy.deepcopy(wpose))

    # wpose.position.y -= 0.2
    # waypoints.append(copy.deepcopy(wpose))

    # wpose.position.x += 0.15
    # waypoints.append(copy.deepcopy(wpose))

    # Planning for two points
    pose_goal = geometry_msgs.msg.Pose()
    pose_goal.position.x = 0.15
    pose_goal.position.y = 0.15
    pose_goal.position.z = 0.1

    #For world frame
    # quaternion = quaternion_from_euler(pi, 0, 0)

    #For buildPlate frame
    quaternion = quaternion_from_euler(pi, 0, pi)

    pose_goal.orientation.x = quaternion[0]
    pose_goal.orientation.y = quaternion[1]
    pose_goal.orientation.z = quaternion[2]
    pose_goal.orientation.w = quaternion[3]

    # move_group.set_joint_value_target({"wrist_3_joint": 0})

    move_group.go(pose_goal, wait=True)
    move_group.stop()
    
    # waypoints.append(copy.deepcopy(pose_goal))

    # (plan, fraction) = move_group.compute_cartesian_path(
    #                                    waypoints,   # waypoints to follow
    #                                    0.01,        # eef_step
    #                                    False)       # jump_threshold

    # Apply Time Parameterization for better speed control
    # time_param = IterativeParabolicTimeParameterization()
    # success, trajectory = time_param.compute_time_stamps(plan)
    
    # if success:
    #     rospy.loginfo("Time parameterization applied successfully.")
    # else:
    #     rospy.logwarn("Time parameterization failed! The trajectory may not execute smoothly.")

    # display_trajectory = moveit_msgs.msg.DisplayTrajectory()
    # display_trajectory.trajectory_start = robot.get_current_state()
    # display_trajectory.trajectory.append(plan)
    # display_trajectory_publisher.publish(display_trajectory)

    # move_group.execute(plan, wait=False)
    # move_group.stop()

    # rospy.loginfo("Executing Cartesian Path at Controlled Speed...")
    # move_group.execute(trajectory, wait=False)  # Execute motion *without waiting*

    # rate = rospy.Rate(10)  # Check position at 10 Hz
    # waypoint_index = 0  # Start checking for the first waypoint

    # while not rospy.is_shutdown():
    #     current_pose = move_group.get_current_pose().pose

    #     # Check only the current waypoint
    #     if is_close(current_pose.position, waypoints[waypoint_index].position):
    #         rospy.loginfo(f"Reached waypoint {waypoint_index + 1}")
    #         feedback_publisher.publish(f"Reached waypoint {waypoint_index + 1}")

    #         waypoint_index += 1  # Move to next waypoint
            
    #         if waypoint_index == len(waypoints):  # If all waypoints reached, exit loop
    #             break  

    #     rate.sleep()

    # rospy.loginfo("Cartesian path execution complete.")
