#!/usr/bin/env python3

import sys
import rospy
import moveit_commander as mc
import moveit_msgs.msg
import geometry_msgs.msg
import yaml
import copy

if __name__ == '__main__':
    mc.roscpp_initialize(sys.argv) 
    rospy.init_node("ur5_apla_toolpath", anonymous=True)
    robot = mc.RobotCommander()
    psi = mc.PlanningSceneInterface()
    move_group = mc.MoveGroupCommander('manipulator')

    display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                                   moveit_msgs.msg.DisplayTrajectory,
                                                   queue_size=20)

    with open('/home/tim/FDMPrinting/src/ur5_apla_moveit_config/config/calibration.yaml') as f:
        doc = yaml.load(f)

    offset = doc['calibration']['z']
    #Go to begin corner

    # pose_goal = geometry_msgs.msg.Pose()
    # pose_goal.position.x = 0
    # pose_goal.position.y = 0.4
    # pose_goal.position.z = 0.002 + offset
    # pose_goal.orientation.x = -1.0
    # pose_goal.orientation.y = 0
    # pose_goal.orientation.z = 0
    # pose_goal.orientation.w = 0

    # move_group.set_pose_target(pose_goal)
    # # plan = move_group.plan()
    # plan = move_group.go(wait=True)
    # move_group.stop()
    # move_group.clear_pose_targets()

    #Planning a square

    waypoints = []

    wpose = move_group.get_current_pose().pose
    wpose.position.y += 0.2
    waypoints.append(copy.deepcopy(wpose))

    wpose.position.x -= 0.15
    waypoints.append(copy.deepcopy(wpose))

    wpose.position.y -= 0.2
    waypoints.append(copy.deepcopy(wpose))

    wpose.position.x += 0.15
    waypoints.append(copy.deepcopy(wpose))

    (plan, fraction) = move_group.compute_cartesian_path(
                                       waypoints,   # waypoints to follow
                                       float(0.01),        # eef_step
                                       False)         # jump_threshold

    display_trajectory = moveit_msgs.msg.DisplayTrajectory()
    display_trajectory.trajectory_start = robot.get_current_state()
    display_trajectory.trajectory.append(plan)
    display_trajectory_publisher.publish(display_trajectory)

    move_group.execute(plan, wait=True)