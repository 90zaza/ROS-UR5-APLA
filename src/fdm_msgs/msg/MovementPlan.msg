# MovementPlan.msg
int32 seq_id  # Sequence IDs to match each movement command
duration execution_time  # Corresponding execution times
moveit_msgs/RobotTrajectory trajectory  # Using an external message type
