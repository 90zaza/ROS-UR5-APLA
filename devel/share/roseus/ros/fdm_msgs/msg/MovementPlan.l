;; Auto-generated. Do not edit!


(when (boundp 'fdm_msgs::MovementPlan)
  (if (not (find-package "FDM_MSGS"))
    (make-package "FDM_MSGS"))
  (shadow 'MovementPlan (find-package "FDM_MSGS")))
(unless (find-package "FDM_MSGS::MOVEMENTPLAN")
  (make-package "FDM_MSGS::MOVEMENTPLAN"))

(in-package "ROS")
;;//! \htmlinclude MovementPlan.msg.html
(if (not (find-package "MOVEIT_MSGS"))
  (ros::roseus-add-msgs "moveit_msgs"))


(defclass fdm_msgs::MovementPlan
  :super ros::object
  :slots (_seq_id _execution_time _trajectory ))

(defmethod fdm_msgs::MovementPlan
  (:init
   (&key
    ((:seq_id __seq_id) 0)
    ((:execution_time __execution_time) (instance ros::time :init))
    ((:trajectory __trajectory) (instance moveit_msgs::RobotTrajectory :init))
    )
   (send-super :init)
   (setq _seq_id (round __seq_id))
   (setq _execution_time __execution_time)
   (setq _trajectory __trajectory)
   self)
  (:seq_id
   (&optional __seq_id)
   (if __seq_id (setq _seq_id __seq_id)) _seq_id)
  (:execution_time
   (&optional __execution_time)
   (if __execution_time (setq _execution_time __execution_time)) _execution_time)
  (:trajectory
   (&rest __trajectory)
   (if (keywordp (car __trajectory))
       (send* _trajectory __trajectory)
     (progn
       (if __trajectory (setq _trajectory (car __trajectory)))
       _trajectory)))
  (:serialization-length
   ()
   (+
    ;; int32 _seq_id
    4
    ;; duration _execution_time
    8
    ;; moveit_msgs/RobotTrajectory _trajectory
    (send _trajectory :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _seq_id
       (write-long _seq_id s)
     ;; duration _execution_time
       (write-long (send _execution_time :sec) s) (write-long (send _execution_time :nsec) s)
     ;; moveit_msgs/RobotTrajectory _trajectory
       (send _trajectory :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _seq_id
     (setq _seq_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; duration _execution_time
     (send _execution_time :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _execution_time :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; moveit_msgs/RobotTrajectory _trajectory
     (send _trajectory :deserialize buf ptr-) (incf ptr- (send _trajectory :serialization-length))
   ;;
   self)
  )

(setf (get fdm_msgs::MovementPlan :md5sum-) "6f421bb5afab38c9bd55dc301c0151a4")
(setf (get fdm_msgs::MovementPlan :datatype-) "fdm_msgs/MovementPlan")
(setf (get fdm_msgs::MovementPlan :definition-)
      "# MovementPlan.msg
int32 seq_id  # Sequence IDs to match each movement command
duration execution_time  # Corresponding execution times
moveit_msgs/RobotTrajectory trajectory  # Using an external message type

================================================================================
MSG: moveit_msgs/RobotTrajectory
trajectory_msgs/JointTrajectory joint_trajectory
trajectory_msgs/MultiDOFJointTrajectory multi_dof_joint_trajectory

================================================================================
MSG: trajectory_msgs/JointTrajectory
Header header
string[] joint_names
JointTrajectoryPoint[] points

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: trajectory_msgs/JointTrajectoryPoint
# Each trajectory point specifies either positions[, velocities[, accelerations]]
# or positions[, effort] for the trajectory to be executed.
# All specified values are in the same order as the joint names in JointTrajectory.msg

float64[] positions
float64[] velocities
float64[] accelerations
float64[] effort
duration time_from_start

================================================================================
MSG: trajectory_msgs/MultiDOFJointTrajectory
# The header is used to specify the coordinate frame and the reference time for the trajectory durations
Header header

# A representation of a multi-dof joint trajectory (each point is a transformation)
# Each point along the trajectory will include an array of positions/velocities/accelerations
# that has the same length as the array of joint names, and has the same order of joints as 
# the joint names array.

string[] joint_names
MultiDOFJointTrajectoryPoint[] points

================================================================================
MSG: trajectory_msgs/MultiDOFJointTrajectoryPoint
# Each multi-dof joint can specify a transform (up to 6 DOF)
geometry_msgs/Transform[] transforms

# There can be a velocity specified for the origin of the joint 
geometry_msgs/Twist[] velocities

# There can be an acceleration specified for the origin of the joint 
geometry_msgs/Twist[] accelerations

duration time_from_start

================================================================================
MSG: geometry_msgs/Transform
# This represents the transform between two coordinate frames in free space.

Vector3 translation
Quaternion rotation

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Twist
# This expresses velocity in free space broken into its linear and angular parts.
Vector3  linear
Vector3  angular

")



(provide :fdm_msgs/MovementPlan "6f421bb5afab38c9bd55dc301c0151a4")


