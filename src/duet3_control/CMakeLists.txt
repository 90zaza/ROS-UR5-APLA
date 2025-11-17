cmake_minimum_required(VERSION 3.1.3)
project(duet3_control)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  fdm_msgs
)

catkin_package()

install(DIRECTORY config DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION})
catkin_install_python(PROGRAMS scripts/duet_communicater.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)