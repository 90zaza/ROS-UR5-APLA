import rospy
from std_msgs.msg import String
import sys

def publish_gcode_lines(file_path):
    rospy.init_node('gcode_publisher', anonymous=True)
    
    movement_pub = rospy.Publisher('gcode_movement', String, queue_size=10)
    printing_pub = rospy.Publisher('gcode_printing', String, queue_size=10)

    # Wait for the HTTP client node (or any subscriber) to connect on gcode_movement
    while movement_pub.get_num_connections() == 0:
        rospy.logwarn("Waiting for subscribers to connect on 'gcode_movement'...")
        rospy.sleep(1)
    
    try:
        with open(file_path, 'r') as file:
            for line in file:
                command = line.strip()
                if not command:
                    continue
                
                rospy.loginfo(f"Publishing: {command}")
                movement_pub.publish(command)
                printing_pub.publish(command)
                
                rospy.loginfo("Waiting for reply from server on 'duet_publisher'...")
                # This will block until a message is received on the 'duet_publisher' topic.
                reply = rospy.wait_for_message("duet_publisher", String)
                rospy.loginfo(f"Received reply: {reply.data}")
                
        rospy.loginfo("Finished processing G-code file.")
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
