# MovementPlan.msg
int32[] seq_ids  # Sequence IDs to match each movement command
float64[] execution_times  # Corresponding execution times
moveit_msgs/RobotTrajectory trajectory  # Using an external message type
