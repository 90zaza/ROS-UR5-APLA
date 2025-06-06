// Generated by gencpp from file fdm_msgs/MovementPlanConsec.msg
// DO NOT EDIT!


#ifndef FDM_MSGS_MESSAGE_MOVEMENTPLANCONSEC_H
#define FDM_MSGS_MESSAGE_MOVEMENTPLANCONSEC_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>

#include <moveit_msgs/RobotTrajectory.h>

namespace fdm_msgs
{
template <class ContainerAllocator>
struct MovementPlanConsec_
{
  typedef MovementPlanConsec_<ContainerAllocator> Type;

  MovementPlanConsec_()
    : seq_ids()
    , timestamps()
    , trajectory()  {
    }
  MovementPlanConsec_(const ContainerAllocator& _alloc)
    : seq_ids(_alloc)
    , timestamps(_alloc)
    , trajectory(_alloc)  {
  (void)_alloc;
    }



   typedef std::vector<int32_t, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<int32_t>> _seq_ids_type;
  _seq_ids_type seq_ids;

   typedef std::vector<ros::Duration, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<ros::Duration>> _timestamps_type;
  _timestamps_type timestamps;

   typedef  ::moveit_msgs::RobotTrajectory_<ContainerAllocator>  _trajectory_type;
  _trajectory_type trajectory;





  typedef boost::shared_ptr< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> const> ConstPtr;

}; // struct MovementPlanConsec_

typedef ::fdm_msgs::MovementPlanConsec_<std::allocator<void> > MovementPlanConsec;

typedef boost::shared_ptr< ::fdm_msgs::MovementPlanConsec > MovementPlanConsecPtr;
typedef boost::shared_ptr< ::fdm_msgs::MovementPlanConsec const> MovementPlanConsecConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator1> & lhs, const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator2> & rhs)
{
  return lhs.seq_ids == rhs.seq_ids &&
    lhs.timestamps == rhs.timestamps &&
    lhs.trajectory == rhs.trajectory;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator1> & lhs, const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace fdm_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a5506cec73306116e5760e0c692a041c";
  }

  static const char* value(const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa5506cec73306116ULL;
  static const uint64_t static_value2 = 0xe5760e0c692a041cULL;
};

template<class ContainerAllocator>
struct DataType< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
{
  static const char* value()
  {
    return "fdm_msgs/MovementPlanConsec";
  }

  static const char* value(const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# MovementPlanConsec.msg\n"
"int32[] seq_ids  # Sequence IDs to match each movement command\n"
"duration[] timestamps  # Corresponding timestamps\n"
"moveit_msgs/RobotTrajectory trajectory  # Corresponding trajectory command\n"
"\n"
"================================================================================\n"
"MSG: moveit_msgs/RobotTrajectory\n"
"trajectory_msgs/JointTrajectory joint_trajectory\n"
"trajectory_msgs/MultiDOFJointTrajectory multi_dof_joint_trajectory\n"
"\n"
"================================================================================\n"
"MSG: trajectory_msgs/JointTrajectory\n"
"Header header\n"
"string[] joint_names\n"
"JointTrajectoryPoint[] points\n"
"\n"
"================================================================================\n"
"MSG: std_msgs/Header\n"
"# Standard metadata for higher-level stamped data types.\n"
"# This is generally used to communicate timestamped data \n"
"# in a particular coordinate frame.\n"
"# \n"
"# sequence ID: consecutively increasing ID \n"
"uint32 seq\n"
"#Two-integer timestamp that is expressed as:\n"
"# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')\n"
"# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')\n"
"# time-handling sugar is provided by the client library\n"
"time stamp\n"
"#Frame this data is associated with\n"
"string frame_id\n"
"\n"
"================================================================================\n"
"MSG: trajectory_msgs/JointTrajectoryPoint\n"
"# Each trajectory point specifies either positions[, velocities[, accelerations]]\n"
"# or positions[, effort] for the trajectory to be executed.\n"
"# All specified values are in the same order as the joint names in JointTrajectory.msg\n"
"\n"
"float64[] positions\n"
"float64[] velocities\n"
"float64[] accelerations\n"
"float64[] effort\n"
"duration time_from_start\n"
"\n"
"================================================================================\n"
"MSG: trajectory_msgs/MultiDOFJointTrajectory\n"
"# The header is used to specify the coordinate frame and the reference time for the trajectory durations\n"
"Header header\n"
"\n"
"# A representation of a multi-dof joint trajectory (each point is a transformation)\n"
"# Each point along the trajectory will include an array of positions/velocities/accelerations\n"
"# that has the same length as the array of joint names, and has the same order of joints as \n"
"# the joint names array.\n"
"\n"
"string[] joint_names\n"
"MultiDOFJointTrajectoryPoint[] points\n"
"\n"
"================================================================================\n"
"MSG: trajectory_msgs/MultiDOFJointTrajectoryPoint\n"
"# Each multi-dof joint can specify a transform (up to 6 DOF)\n"
"geometry_msgs/Transform[] transforms\n"
"\n"
"# There can be a velocity specified for the origin of the joint \n"
"geometry_msgs/Twist[] velocities\n"
"\n"
"# There can be an acceleration specified for the origin of the joint \n"
"geometry_msgs/Twist[] accelerations\n"
"\n"
"duration time_from_start\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Transform\n"
"# This represents the transform between two coordinate frames in free space.\n"
"\n"
"Vector3 translation\n"
"Quaternion rotation\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Vector3\n"
"# This represents a vector in free space. \n"
"# It is only meant to represent a direction. Therefore, it does not\n"
"# make sense to apply a translation to it (e.g., when applying a \n"
"# generic rigid transformation to a Vector3, tf2 will only apply the\n"
"# rotation). If you want your data to be translatable too, use the\n"
"# geometry_msgs/Point message instead.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"================================================================================\n"
"MSG: geometry_msgs/Quaternion\n"
"# This represents an orientation in free space in quaternion form.\n"
"\n"
"float64 x\n"
"float64 y\n"
"float64 z\n"
"float64 w\n"
"\n"
"================================================================================\n"
"MSG: geometry_msgs/Twist\n"
"# This expresses velocity in free space broken into its linear and angular parts.\n"
"Vector3  linear\n"
"Vector3  angular\n"
;
  }

  static const char* value(const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.seq_ids);
      stream.next(m.timestamps);
      stream.next(m.trajectory);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct MovementPlanConsec_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::fdm_msgs::MovementPlanConsec_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::fdm_msgs::MovementPlanConsec_<ContainerAllocator>& v)
  {
    s << indent << "seq_ids[]" << std::endl;
    for (size_t i = 0; i < v.seq_ids.size(); ++i)
    {
      s << indent << "  seq_ids[" << i << "]: ";
      Printer<int32_t>::stream(s, indent + "  ", v.seq_ids[i]);
    }
    s << indent << "timestamps[]" << std::endl;
    for (size_t i = 0; i < v.timestamps.size(); ++i)
    {
      s << indent << "  timestamps[" << i << "]: ";
      Printer<ros::Duration>::stream(s, indent + "  ", v.timestamps[i]);
    }
    s << indent << "trajectory: ";
    s << std::endl;
    Printer< ::moveit_msgs::RobotTrajectory_<ContainerAllocator> >::stream(s, indent + "  ", v.trajectory);
  }
};

} // namespace message_operations
} // namespace ros

#endif // FDM_MSGS_MESSAGE_MOVEMENTPLANCONSEC_H
