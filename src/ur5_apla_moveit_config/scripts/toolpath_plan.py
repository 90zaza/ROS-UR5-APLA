#!/usr/bin/env python
import rospy
import copy
import json
import threading
import tf2_ros
import tf2_geometry_msgs
import std_msgs.msg
import moveit_msgs.msg
import sensor_msgs.msg
import geometry_msgs.msg
import moveit_commander as mc
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

        self.waypoints = []
        self.trajectory_list = []
        self.last_time = rospy.Duration(0)

        self.display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                            moveit_msgs.msg.DisplayTrajectory,
                                            queue_size=20)
        self.display_trajectory = moveit_msgs.msg.DisplayTrajectory()
        self.display_trajectory.trajectory_start = self.robot.get_current_state()

        self.current_waypoint_publisher = rospy.Publisher('/ur5_current_waypoint', std_msgs.msg.String, queue_size=10)


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
                self.waypoints.append(copy.deepcopy(self.pose_goal))
                self.computePlan()
        return
    
    def computePlan(self):
        (self.plan, self.fraction) = self.move_group.compute_cartesian_path(
                                       [copy.deepcopy(self.pose_goal)],
                                       0.01,
                                       False)
        
        self.latest_joint_positions = copy.deepcopy(self.plan).joint_trajectory.points[-1].positions
        self.joint_state.position = copy.deepcopy(self.latest_joint_positions)
        self.robot_state.joint_state = copy.deepcopy(self.joint_state)
        self.move_group.set_start_state(copy.deepcopy(self.robot_state))
        
        if self.fraction > 0:
            for point in self.plan.joint_trajectory.points:
                if point.time_from_start.to_sec() == 0:
                    point.time_from_start += rospy.Duration(nsecs=1)
                point.time_from_start += self.last_time
            
            self.last_time = self.plan.joint_trajectory.points[-1].time_from_start
            self.trajectory_list.append(copy.deepcopy(self.plan))
    
    def showPlan(self):
        print('Displaying full trajectory in Rviz!')

        for plan in self.trajectory_list:
            self.display_trajectory.trajectory.append(plan)

        self.display_trajectory_publisher.publish(self.display_trajectory)

        self.transformWaypointsToGlobal()
        input("Press Enter to execute the trajectory...")
        waypoint_thread = threading.Thread(target=self.checkWaypoints)
        waypoint_thread.start()

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

    def transformWaypointsToGlobal(self):
        tf_buffer = tf2_ros.Buffer()
        tf_listener = tf2_ros.TransformListener(tf_buffer)

        rospy.sleep(1.0)
        
        self.transformed_waypoints = []
        try:
            for waypoint in self.waypoints:
                waypoint_stamped = geometry_msgs.msg.PoseStamped()
                waypoint_stamped.header.frame_id = 'buildPlate'
                waypoint_stamped.pose = waypoint
                
                transform = tf_buffer.lookup_transform(
                    'base_link',  # Target frame (global frame)
                    'buildPlate',  # Source frame
                    rospy.Time(0),  # Get the latest transform available
                    rospy.Duration(1.0)  # Timeout for transform
                )
                transformed_waypoint = tf2_geometry_msgs.do_transform_pose(waypoint_stamped, transform)
                self.transformed_waypoints.append(transformed_waypoint.pose.position)
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException):
            rospy.logwarn("TF lookup failed for waypoints, using original waypoints.")
            self.transformed_waypoints = [wp.position for wp in self.waypoints]

    def is_close(self, pos1, pos2, threshold=0.005):
        """Check if two positions are within a certain threshold."""
        return (abs(pos1.x - pos2.x) < threshold and 
                abs(pos1.y - pos2.y) < threshold and 
                abs(pos1.z - pos2.z) < threshold)

    def checkWaypoints(self):
        waypoint_index = 0
        
        while waypoint_index < len(self.transformed_waypoints) and not rospy.is_shutdown():
            current_pose_stamped = self.move_group.get_current_pose()
            current_position = current_pose_stamped.pose.position
            
            print(f"Checking waypoint {waypoint_index + 1}/{len(self.transformed_waypoints)}")
            print(f"Current Position: x={current_position.x}, y={current_position.y}, z={current_position.z}")
            print(f"Target Position: x={self.transformed_waypoints[waypoint_index].x}, y={self.transformed_waypoints[waypoint_index].y}, z={self.transformed_waypoints[waypoint_index].z}")
            
            # Check if we are close to the waypoint
            if self.is_close(current_position, self.transformed_waypoints[waypoint_index]):
                rospy.loginfo(f"Reached waypoint {waypoint_index + 1}")
                self.current_waypoint_publisher.publish(f"Reached waypoint {waypoint_index + 1}")
                waypoint_index += 1
            else:
                print("Not close enough yet.")
            
            rospy.Rate(10).sleep()
        
        print("All waypoints reached!")


if __name__ == '__main__':
    toolpathPlan = toolpathPlan()
    toolpathPlan.subscriber()