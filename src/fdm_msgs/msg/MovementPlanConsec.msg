# MovementPlanConsec.msg
int32[] seq_ids  # Sequence IDs to match each movement command
duration[] timestamps  # Corresponding timestamps
moveit_msgs/RobotTrajectory trajectory  # Corresponding trajectory command
