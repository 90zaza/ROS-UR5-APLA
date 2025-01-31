cmake_minimum_required(VERSION 3.1.3)
project(gcode_interpreter)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)

catkin_package()

install(DIRECTORY config DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
catkin_install_python(PROGRAMS scripts/gcode_loader.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
