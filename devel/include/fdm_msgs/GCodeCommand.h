// Generated by gencpp from file fdm_msgs/GCodeCommand.msg
// DO NOT EDIT!


#ifndef FDM_MSGS_MESSAGE_GCODECOMMAND_H
#define FDM_MSGS_MESSAGE_GCODECOMMAND_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace fdm_msgs
{
template <class ContainerAllocator>
struct GCodeCommand_
{
  typedef GCodeCommand_<ContainerAllocator> Type;

  GCodeCommand_()
    : seq_id(0)
    , cmd_id(0)
    , x(0.0)
    , y(0.0)
    , z(0.0)
    , f(0.0)
    , printing_command()
    , has_movement(false)
    , has_printing(false)
    , is_final(false)  {
    }
  GCodeCommand_(const ContainerAllocator& _alloc)
    : seq_id(0)
    , cmd_id(0)
    , x(0.0)
    , y(0.0)
    , z(0.0)
    , f(0.0)
    , printing_command(_alloc)
    , has_movement(false)
    , has_printing(false)
    , is_final(false)  {
  (void)_alloc;
    }



   typedef int32_t _seq_id_type;
  _seq_id_type seq_id;

   typedef int32_t _cmd_id_type;
  _cmd_id_type cmd_id;

   typedef double _x_type;
  _x_type x;

   typedef double _y_type;
  _y_type y;

   typedef double _z_type;
  _z_type z;

   typedef double _f_type;
  _f_type f;

   typedef std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>> _printing_command_type;
  _printing_command_type printing_command;

   typedef uint8_t _has_movement_type;
  _has_movement_type has_movement;

   typedef uint8_t _has_printing_type;
  _has_printing_type has_printing;

   typedef uint8_t _is_final_type;
  _is_final_type is_final;





  typedef boost::shared_ptr< ::fdm_msgs::GCodeCommand_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::fdm_msgs::GCodeCommand_<ContainerAllocator> const> ConstPtr;

}; // struct GCodeCommand_

typedef ::fdm_msgs::GCodeCommand_<std::allocator<void> > GCodeCommand;

typedef boost::shared_ptr< ::fdm_msgs::GCodeCommand > GCodeCommandPtr;
typedef boost::shared_ptr< ::fdm_msgs::GCodeCommand const> GCodeCommandConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::fdm_msgs::GCodeCommand_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::fdm_msgs::GCodeCommand_<ContainerAllocator1> & lhs, const ::fdm_msgs::GCodeCommand_<ContainerAllocator2> & rhs)
{
  return lhs.seq_id == rhs.seq_id &&
    lhs.cmd_id == rhs.cmd_id &&
    lhs.x == rhs.x &&
    lhs.y == rhs.y &&
    lhs.z == rhs.z &&
    lhs.f == rhs.f &&
    lhs.printing_command == rhs.printing_command &&
    lhs.has_movement == rhs.has_movement &&
    lhs.has_printing == rhs.has_printing &&
    lhs.is_final == rhs.is_final;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::fdm_msgs::GCodeCommand_<ContainerAllocator1> & lhs, const ::fdm_msgs::GCodeCommand_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace fdm_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::fdm_msgs::GCodeCommand_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::fdm_msgs::GCodeCommand_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::fdm_msgs::GCodeCommand_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
{
  static const char* value()
  {
    return "adfc96e244d9dd15b863f79af34eb1fe";
  }

  static const char* value(const ::fdm_msgs::GCodeCommand_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xadfc96e244d9dd15ULL;
  static const uint64_t static_value2 = 0xb863f79af34eb1feULL;
};

template<class ContainerAllocator>
struct DataType< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
{
  static const char* value()
  {
    return "fdm_msgs/GCodeCommand";
  }

  static const char* value(const ::fdm_msgs::GCodeCommand_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# GCodeCommand.msg\n"
"int32 seq_id  # Unique ID to maintain execution order\n"
"int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file\n"
"float64 x # Position in mm\n"
"float64 y # Position in mm\n"
"float64 z # Position in mm\n"
"float64 f  # Speed of movement in mm/min\n"
"string printing_command  # Raw gCode like \"M82\"\n"
"bool has_movement  # True if there is a movement command\n"
"bool has_printing  # True if there is a printing command\n"
"bool is_final # True if it is the final command\n"
;
  }

  static const char* value(const ::fdm_msgs::GCodeCommand_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.seq_id);
      stream.next(m.cmd_id);
      stream.next(m.x);
      stream.next(m.y);
      stream.next(m.z);
      stream.next(m.f);
      stream.next(m.printing_command);
      stream.next(m.has_movement);
      stream.next(m.has_printing);
      stream.next(m.is_final);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GCodeCommand_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::fdm_msgs::GCodeCommand_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::fdm_msgs::GCodeCommand_<ContainerAllocator>& v)
  {
    if (false || !indent.empty())
      s << std::endl;
    s << indent << "seq_id: ";
    Printer<int32_t>::stream(s, indent + "  ", v.seq_id);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "cmd_id: ";
    Printer<int32_t>::stream(s, indent + "  ", v.cmd_id);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "x: ";
    Printer<double>::stream(s, indent + "  ", v.x);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "y: ";
    Printer<double>::stream(s, indent + "  ", v.y);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "z: ";
    Printer<double>::stream(s, indent + "  ", v.z);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "f: ";
    Printer<double>::stream(s, indent + "  ", v.f);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "printing_command: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.printing_command);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "has_movement: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.has_movement);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "has_printing: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.has_printing);
    if (true || !indent.empty())
      s << std::endl;
    s << indent << "is_final: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.is_final);
  }
};

} // namespace message_operations
} // namespace ros

#endif // FDM_MSGS_MESSAGE_GCODECOMMAND_H
