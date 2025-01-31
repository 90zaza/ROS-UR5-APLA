import rospy
from std_msgs.msg import String
import sys

def publish_gcode_lines(file_path):
    rospy.init_node('gcode_publisher', anonymous=True)
    
    movement_pub = rospy.Publisher('gcode_movement', String, queue_size=10)
    printing_pub = rospy.Publisher('gcode_printing', String, queue_size=10)
    
    rate = rospy.Rate(10)  # 10 Hz
    
    try:
        with open(file_path, 'r') as file:
            for line in file:
                line = line.strip()
                if not line:
                    continue
                
                rospy.loginfo(f"Publishing: {line}")
                movement_pub.publish(line)
                printing_pub.publish(line)
                
                rate.sleep()
    except Exception as e:
        rospy.logerr(f"Error reading file: {e}")

if __name__ == '__main__':
    try:
        if len(sys.argv) < 2:
            rospy.logerr("Usage: rosrun gcode_interpreter gcode_loader <file.gcode>")
            sys.exit(1)
        
        gcode_file_path = sys.argv[1]
        publish_gcode_lines(gcode_file_path)
    except rospy.ROSInterruptException:
        pass