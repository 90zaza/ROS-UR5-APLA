#!/usr/bin/env python

import sys
import rospy
import rospkg
import os
import tf
import yaml
import moveit_commander as mc
from geometry_msgs.msg import PoseStamped, Pose, Point, Quaternion
from std_msgs.msg import Header
from math import pi

if __name__ == '__main__':
    mc.roscpp_initialize(sys.argv) 
    rospy.init_node("ur5_apla_workcell", anonymous=True)
    robot = mc.RobotCommander()
    psi = mc.PlanningSceneInterface()
    br = tf.TransformBroadcaster()
    rate = rospy.Rate(10.0)

    pkg_path = rospkg.RosPack().get_path('ur5_apla_moveit_config')
    yaml_path = os.path.join(pkg_path, 'config', 'calibration.yaml')

    with open(yaml_path, 'r') as f:
        doc = yaml.load(f, Loader=yaml.FullLoader)

    buildPlate = doc['calibration']['plate']
    
    # rospy.sleep(1)

    psi.remove_attached_object()
    psi.remove_world_object()

    psi.add_box(
        name="ground_box", 
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0, y=0.33 ,z=-0.005), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.7, 0.9, 0.01))
    
    psi.attach_box('world', 'ground_box', touch_links = ['base', 'base_link', 'base_link_inertia'])

    psi.add_box(
        name="filament_dispenser",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0.265, y=-0.015, z=0.125), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.17, 0.21, 0.25))
    
    psi.attach_box('world', 'filament_dispenser')
    
    #Sides of the build plate are 0.08m from the side of the bench
    psi.add_box(
        name="build_plate",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0, y=0.5, z=buildPlate/2), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.40, 0.40, buildPlate))
    
    psi.attach_box('world', 'build_plate')

    # psi.add_box(
    #     name="build_plate_screw_back",
    #     pose=PoseStamped(
    #         header=Header(frame_id=robot.get_planning_frame()),
    #         pose=Pose(position=Point(x=-0.27625, y=0.5, z=0.015), orientation=Quaternion(x=0, y=0, z=0, w=1))),
    #     size=(0.03, 0.03, 0.03))
    
    # psi.attach_box('world', 'build_plate_screw_back')

    # psi.add_box(
    #     name="build_plate_screw_front",
    #     pose=PoseStamped(
    #         header=Header(frame_id=robot.get_planning_frame()),
    #         pose=Pose(position=Point(x=0.27625, y=0.5, z=0.015), orientation=Quaternion(x=0, y=0, z=0, w=1))),
    #     size=(0.03, 0.03, 0.03))
    
    # psi.attach_box('world', 'build_plate_screw_front')

    psi.add_box(
        name="build_plate_screw_left_back",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=-0.15, y=0.285, z=buildPlate+0.01), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.03, 0.03, 0.02))
    
    psi.attach_box('world', 'build_plate_screw_left_back')

    psi.add_box(
        name="build_plate_screw_left_front",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0.15, y=0.285, z=buildPlate+0.01), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.03, 0.03, 0.02))
    
    psi.attach_box('world', 'build_plate_screw_left_front')

    psi.add_box(
        name="build_plate_screw_right_back",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=-0.17, y=0.715, z=buildPlate+0.01), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.03, 0.03, 0.02))
    
    psi.attach_box('world', 'build_plate_screw_right_back')

    psi.add_box(
        name="build_plate_screw_right_front",
        pose=PoseStamped(
            header=Header(frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0.17, y=0.715, z=buildPlate+0.01), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        size=(0.03, 0.03, 0.02))
    
    psi.attach_box('world', 'build_plate_screw_right_front')




    #Ceiling is at 1.80m, workbench is at 0.835m, top plane is located at 1.80 - 0.835 = 0.965m
    psi.add_plane(
        name="top_plane", 
        pose=PoseStamped(
            header=Header(stamp=rospy.Time.now(), frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0, y=0 ,z=0.965), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        normal=(0,0,1),
        offset=0)
    
    # psi.add_plane(
    #     name="left_plane", 
    #     pose=PoseStamped(
    #         header=Header(stamp=rospy.Time.now(), frame_id=robot.get_planning_frame()),
    #         pose=Pose(position=Point(x=0, y=-0.12 ,z=0), orientation=Quaternion(x=0, y=0, z=0, w=1))),
    #     normal=(0,1,0),
    #     offset=0)
    
    psi.add_plane(
        name="right_plane", 
        pose=PoseStamped(
            header=Header(stamp=rospy.Time.now(), frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0, y=0.78 ,z=0), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        normal=(0,1,0),
        offset=0)
    
    psi.add_plane(
        name="back_plane", 
        pose=PoseStamped(
            header=Header(stamp=rospy.Time.now(), frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=-0.35, y=0 ,z=0), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        normal=(1,0,0),
        offset=0)
    
    psi.add_plane(
        name="front_plane", 
        pose=PoseStamped(
            header=Header(stamp=rospy.Time.now(), frame_id=robot.get_planning_frame()),
            pose=Pose(position=Point(x=0.35, y=0 ,z=0), orientation=Quaternion(x=0, y=0, z=0, w=1))),
        normal=(1,0,0),
        offset=0)
    
    rospy.loginfo(psi.get_known_object_names())
    
    while not rospy.is_shutdown():
        br.sendTransform((0.15, 0.65, buildPlate),
                        tf.transformations.quaternion_from_euler(0, 0, -1*pi),
                        rospy.Time.now(),
                        "buildPlate",
                        "world")
        rate.sleep()
    
    mc.roscpp_shutdown()