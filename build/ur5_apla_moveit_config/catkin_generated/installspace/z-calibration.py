import sys
import rospy
import moveit_commander as mc
import moveit_msgs.msg
import yaml
from math import pi
     
def go_to_home():
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

def get_zposition(zpos):
  current_pose = move_group.get_current_pose().pose
  print(current_pose.position.z)
  zpos.append(current_pose.position.z)

  return

def calcluate_offset(zpos):
  offset = (sum(zpos) / len(zpos)) - 0.002
  print("The mean offset is: ", offset)

  with open('/home/tim/FDMPrinting/src/ur5_apla_moveit_config/config/calibration.yaml') as f:
    doc = yaml.load(f)

  doc['calibration']['z'] = offset

  with open('/home/tim/FDMPrinting/src/ur5_apla_moveit_config/config/calibration.yaml', 'w') as f:
    yaml.dump(doc, f)

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

    print ("First instance: Move the TCP to the printbed, press 'Enter' once done")
    input()
    get_zposition(zpos)
    go_to_home()

    print ("Second instance: Move the TCP to the printbed, press 'Enter' once done")
    input()
    get_zposition(zpos)
    go_to_home()

    print ("Third instance: Move the TCP to the printbed, press 'Enter' once done")
    input()
    get_zposition(zpos)
    calcluate_offset(zpos)
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
  
  zpos = []
  main()