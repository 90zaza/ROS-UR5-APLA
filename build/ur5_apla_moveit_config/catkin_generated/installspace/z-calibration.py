import sys
import rospy
import moveit_commander as mc
import moveit_msgs.msg
import geometry_msgs.msg
from tf.transformations import quaternion_from_euler
from math import pi
     
def go_to_home():
  move_group.set_pose_reference_frame('world')
  joint_goal = move_group.get_current_joint_values()
  joint_goal[0] = pi/2
  joint_goal[1] = -pi/2
  joint_goal[2] = pi/2
  joint_goal[3] = 3*pi/2
  joint_goal[4] = 3*pi/2
  joint_goal[5] = 0

  move_group.go(joint_goal, wait=True)
  move_group.stop()

  return

def go_to_position(x_pos, y_pos):
  move_group.set_max_velocity_scaling_factor(0.1)
  move_group.set_max_acceleration_scaling_factor(0.5)

  move_group.set_pose_reference_frame('buildPlate')
  pose_goal = geometry_msgs.msg.Pose()
  pose_goal.position.x = x_pos
  pose_goal.position.y = y_pos
  pose_goal.position.z = 0
  
  quaternion = quaternion_from_euler(pi, 0, pi)

  pose_goal.orientation.x = quaternion[0]
  pose_goal.orientation.y = quaternion[1]
  pose_goal.orientation.z = quaternion[2]
  pose_goal.orientation.w = quaternion[3]

  move_group.go(pose_goal, wait=True)
  move_group.stop()

  return

def main():
  try:
    print ("")
    print ("-----------------------------------------------------------------------------")
    print ("Welcome to the toolhead z-calibration manager for the UR5 in the Applied Labs")
    print ("-----------------------------------------------------------------------------")
    print ("Press Ctrl-D to exit at any time")
    print ("")
    print ("We first ensure that the robotic-arm is in home position")
    
    go_to_home()

    print ("Now we start the calibration")
    go_to_position(-0.02, -0.02)

    print ("Adjust the first corner, press Enter once done")
    input()
    go_to_home()
    go_to_position(0.32, -0.02)

    print ("Adjust the second corner")
    input()
    go_to_home()
    go_to_position(0.32, 0.32)

    print ("Adjust the third corner")
    input()
    go_to_home()
    go_to_position(-0.02, 0.32)

    print ("Adjust the fourth corner")
    input()
    go_to_home()
    go_to_position(0.15, 0.15)

    print ("Check for the center of the bed")
    input()
    go_to_home()

    print ("============ Calibration complete!")
  except rospy.ROSInterruptException:
    return
  except KeyboardInterrupt:
    return
  
if __name__ == '__main__':
  mc.roscpp_initialize(sys.argv) 
  rospy.init_node("ur5_apla_toolpath", anonymous=True)
  robot = mc.RobotCommander()
  psi = mc.PlanningSceneInterface()
  move_group = mc.MoveGroupCommander('manipulator')

  display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path',
                                                  moveit_msgs.msg.DisplayTrajectory,
                                                  queue_size=20)
  
  main()