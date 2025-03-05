import rospy
import requests
import urllib.parse
import std_msgs.msg
import fdm_msgs.msg
from std_srvs.srv import Trigger, TriggerResponse

class Communication:
    def __init__(self):
        self.duetCommunicater = None

        self.duetResponse_publisher = rospy.Publisher('/duet_response', std_msgs.msg.String, queue_size=10)
    
    def set_class_pointers(self, duetCommunicater):
        self.duetCommunicater = duetCommunicater

        return

    def set_subscribers(self):
        rospy.Subscriber("duet_request", fdm_msgs.msg.GCodeCommand, self.duetCommunicater.sendCommand)

        return

    def wait_for_publishers(self):
        while self.duetResponse_publisher.get_num_connections() == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'duet_response'...")
            rospy.sleep(1)

        rospy.sleep(2)
        rospy.loginfo("Communication initialized for gcode_loader.py. Publishing to /duet_response")

        return


    def publish_duet_response(self, cmd):
        self.duetResponse_publisher.publish(cmd)

        return

class DuetCommunicater:
    def __init__(self, comms):
        self.url = rospy.get_param('~server_url', 'http://172.19.126.242')
        self.comms = comms
        
    def sendCommand(self, msg):
        print(f"Received G-code command: {msg.printing_command}")
        try:
            command = msg.printing_command.data.strip().replace("\r", "")
            command_encoded = urllib.parse.quote(command)
            full_url = f"{self.url}/rr_gcode?gcode={command_encoded}"
            rospy.loginfo("Sending command to: %s", full_url)
            
            reply = requests.get(full_url).text.strip()
            
            print(reply)
            if not msg.has_movement:
                self.ask_reply()

        except Exception as e:
            rospy.logerr("Error sending command: %s", e)

    def ask_reply(self):
        reply_url = f"{self.url}/rr_reply"
        try:
            # Use a long timeout (e.g., 30 seconds) to allow the server to return a reply
            response = requests.get(reply_url)
            reply = response.text.strip()
            print(reply)
            return
        except Exception as e:
            rospy.logerr("Error fetching rr_reply: %s", e)
            return

def main():
    rospy.init_node('duetCommunicater', anonymous=True)

    comms = Communication()
    duetCommunicater = DuetCommunicater(comms)

    comms.set_class_pointers(duetCommunicater)
    comms.set_subscribers()
    comms.wait_for_publishers()
    
    rospy.spin()

if __name__ == '__main__':
    main()