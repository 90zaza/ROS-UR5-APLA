import rospy
import math
import copy
import numpy as np
import tf
from moveit_commander import MoveGroupCommander, RobotCommander, PlanningSceneInterface
from moveit_commander.robot_trajectory import RobotTrajectory
from moveit_commander.time_parameterization import IterativeParabolicTimeParameterization
from geometry_msgs.msg import Pose

class SmoothCartesianMover:
    def __init__(self, move_group_name="manipulator", eef_step=0.005):
        self.move_group = MoveGroupCommander(move_group_name)
        self.robot = RobotCommander()
        self.scene = PlanningSceneInterface()
        self.eef_step = eef_step
        self.move_group.set_pose_reference_frame('buildPlate')

    def quaternion_slerp(self, q0, q1, fraction):
        q0 = np.array(q0, dtype=np.float64)
        q1 = np.array(q1, dtype=np.float64)
        dot = np.dot(q0, q1)

        if dot < 0.0:
            q1 = -q1
            dot = -dot

        DOT_THRESHOLD = 0.9995
        if dot > DOT_THRESHOLD:
            result = q0 + fraction * (q1 - q0)
            return result / np.linalg.norm(result)

        theta_0 = np.arccos(dot)
        sin_theta_0 = np.sin(theta_0)
        theta = theta_0 * fraction
        sin_theta = np.sin(theta)

        s0 = np.cos(theta) - dot * sin_theta / sin_theta_0
        s1 = sin_theta / sin_theta_0

        return (s0 * q0) + (s1 * q1)

    def move_linear_rotate(self, speed, position_target, rotation_target):
        start_pose = self.move_group.get_current_pose().pose
        waypoints = []

        # Convert inputs
        target_quat = tf.transformations.quaternion_from_euler(*rotation_target)
        start_quat = [
            start_pose.orientation.x,
            start_pose.orientation.y,
            start_pose.orientation.z,
            start_pose.orientation.w
        ]

        # Compute straight-line distance
        dx = position_target[0] - start_pose.position.x
        dy = position_target[1] - start_pose.position.y
        dz = position_target[2] - start_pose.position.z
        path_length = math.sqrt(dx**2 + dy**2 + dz**2)

        # Number of interpolation steps
        num_steps = max(2, int(path_length / self.eef_step))

        for step in range(1, num_steps + 1):
            pose = Pose()
            fraction = step / num_steps

            pose.position.x = start_pose.position.x + dx * fraction
            pose.position.y = start_pose.position.y + dy * fraction
            pose.position.z = start_pose.position.z + dz * fraction

            interp_quat = self.quaternion_slerp(start_quat, target_quat, fraction)
            pose.orientation.x = interp_quat[0]
            pose.orientation.y = interp_quat[1]
            pose.orientation.z = interp_quat[2]
            pose.orientation.w = interp_quat[3]

            waypoints.append(pose)

        # Plan Cartesian path
        (plan, fraction) = self.move_group.compute_cartesian_path(
            waypoints,
            self.eef_step,
            0.0
        )

        if fraction < 1.0:
            rospy.logwarn(f"Only {fraction*100:.1f}% of the path was planned. Check for collisions or limits.")

        # Time parametrization
        new_plan = RobotTrajectory()
        new_plan.joint_trajectory = plan.joint_trajectory

        iptp = IterativeParabolicTimeParameterization()
        success = iptp.compute_time_stamps(new_plan)

        if not success:
            rospy.logerr("Time parametrization failed. Executing original plan.")
            self.move_group.execute(plan, wait=True)
            return

        # Overwrite trajectory time to match desired linear speed
        total_time = path_length / speed
        n_points = len(new_plan.joint_trajectory.points)

        for i in range(n_points):
            t = (i / (n_points - 1)) * total_time
            new_plan.joint_trajectory.points[i].time_from_start = rospy.Duration.from_sec(t)

        # Execute
        self.move_group.execute(new_plan, wait=True)

if __name__ == '__main__':
    rospy.init_node("ur5_smooth_cartesian_demo")

    mover = SmoothCartesianMover()

    # Move to [x, y, z] = [0.5, 0.0, 0.3] at 0.3 m/s
    # Final orientation: roll=0, pitch=0, yaw=90 degrees
    target_position = [0.5, 0.0, 0.3]
    target_orientation = [0, math.radians(45), 0]
    linear_speed = 0.3

    mover.move_linear_rotate(linear_speed, target_position, target_orientation)
