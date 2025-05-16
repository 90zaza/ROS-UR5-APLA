# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "fdm_msgs: 4 messages, 0 services")

set(MSG_I_FLAGS "-Ifdm_msgs:/home/tim/FDMPrinting/src/fdm_msgs/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Imoveit_msgs:/opt/ros/noetic/share/moveit_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Itrajectory_msgs:/opt/ros/noetic/share/trajectory_msgs/cmake/../msg;-Ishape_msgs:/opt/ros/noetic/share/shape_msgs/cmake/../msg;-Iobject_recognition_msgs:/opt/ros/noetic/share/object_recognition_msgs/cmake/../msg;-Ioctomap_msgs:/opt/ros/noetic/share/octomap_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(fdm_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_custom_target(_fdm_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "fdm_msgs" "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" ""
)

get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_custom_target(_fdm_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "fdm_msgs" "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" ""
)

get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_custom_target(_fdm_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "fdm_msgs" "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" "std_msgs/Header:trajectory_msgs/JointTrajectoryPoint:trajectory_msgs/MultiDOFJointTrajectory:trajectory_msgs/MultiDOFJointTrajectoryPoint:geometry_msgs/Vector3:geometry_msgs/Quaternion:geometry_msgs/Transform:geometry_msgs/Twist:moveit_msgs/RobotTrajectory:trajectory_msgs/JointTrajectory"
)

get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_custom_target(_fdm_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "fdm_msgs" "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" "std_msgs/Header:trajectory_msgs/JointTrajectoryPoint:trajectory_msgs/MultiDOFJointTrajectory:trajectory_msgs/MultiDOFJointTrajectoryPoint:geometry_msgs/Vector3:geometry_msgs/Quaternion:geometry_msgs/Transform:geometry_msgs/Twist:moveit_msgs/RobotTrajectory:trajectory_msgs/JointTrajectory"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_cpp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_cpp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_cpp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(fdm_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(fdm_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(fdm_msgs_generate_messages fdm_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_cpp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_cpp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_cpp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_cpp _fdm_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(fdm_msgs_gencpp)
add_dependencies(fdm_msgs_gencpp fdm_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS fdm_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
)
_generate_msg_eus(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
)
_generate_msg_eus(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
)
_generate_msg_eus(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(fdm_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(fdm_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(fdm_msgs_generate_messages fdm_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_eus _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_eus _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_eus _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_eus _fdm_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(fdm_msgs_geneus)
add_dependencies(fdm_msgs_geneus fdm_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS fdm_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_lisp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_lisp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
)
_generate_msg_lisp(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(fdm_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(fdm_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(fdm_msgs_generate_messages fdm_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_lisp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_lisp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_lisp _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_lisp _fdm_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(fdm_msgs_genlisp)
add_dependencies(fdm_msgs_genlisp fdm_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS fdm_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
)
_generate_msg_nodejs(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
)
_generate_msg_nodejs(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
)
_generate_msg_nodejs(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(fdm_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(fdm_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(fdm_msgs_generate_messages fdm_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_nodejs _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_nodejs _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_nodejs _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_nodejs _fdm_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(fdm_msgs_gennodejs)
add_dependencies(fdm_msgs_gennodejs fdm_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS fdm_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
)
_generate_msg_py(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
)
_generate_msg_py(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
)
_generate_msg_py(fdm_msgs
  "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectoryPoint.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/MultiDOFJointTrajectoryPoint.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Transform.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Twist.msg;/opt/ros/noetic/share/moveit_msgs/cmake/../msg/RobotTrajectory.msg;/opt/ros/noetic/share/trajectory_msgs/cmake/../msg/JointTrajectory.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(fdm_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(fdm_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(fdm_msgs_generate_messages fdm_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCode.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_py _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/GCodeCommand.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_py _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlan.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_py _fdm_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tim/FDMPrinting/src/fdm_msgs/msg/MovementPlanConsec.msg" NAME_WE)
add_dependencies(fdm_msgs_generate_messages_py _fdm_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(fdm_msgs_genpy)
add_dependencies(fdm_msgs_genpy fdm_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS fdm_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/fdm_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(fdm_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET moveit_msgs_generate_messages_cpp)
  add_dependencies(fdm_msgs_generate_messages_cpp moveit_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/fdm_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(fdm_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET moveit_msgs_generate_messages_eus)
  add_dependencies(fdm_msgs_generate_messages_eus moveit_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/fdm_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(fdm_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET moveit_msgs_generate_messages_lisp)
  add_dependencies(fdm_msgs_generate_messages_lisp moveit_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/fdm_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(fdm_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET moveit_msgs_generate_messages_nodejs)
  add_dependencies(fdm_msgs_generate_messages_nodejs moveit_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
    DESTINATION ${genpy_INSTALL_DIR}
    # skip all init files
    PATTERN "__init__.py" EXCLUDE
    PATTERN "__init__.pyc" EXCLUDE
  )
  # install init files which are not in the root folder of the generated code
  string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" ESCAPED_PATH "${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs")
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/fdm_msgs
    DESTINATION ${genpy_INSTALL_DIR}
    FILES_MATCHING
    REGEX "${ESCAPED_PATH}/.+/__init__.pyc?$"
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(fdm_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET moveit_msgs_generate_messages_py)
  add_dependencies(fdm_msgs_generate_messages_py moveit_msgs_generate_messages_py)
endif()
