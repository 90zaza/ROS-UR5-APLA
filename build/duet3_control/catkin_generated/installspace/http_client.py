import rospy
import requests
import time
import urllib.parse
from std_msgs.msg import String
from std_srvs.srv import Trigger, TriggerResponse

class HttpClientNode:
    def __init__(self):
        rospy.init_node('http_client_node', anonymous=True)
        self.url = rospy.get_param('~server_url', 'http://172.19.126.242')
        
        # Publisher for replies (this is what the gcode loader is waiting on)
        self.duet_pub = rospy.Publisher('duet_publisher', String, queue_size=10)
        
        # Subscriber for incoming G-code commands
        self.command_sub = rospy.Subscriber('gcode_movement', String, self.send_request)
        
        # Service for manual triggering (retained for potential future use)
        self.server = rospy.Service('trigger_request', Trigger, self.handle_trigger)
        
        rospy.loginfo("HTTP Client Node Started. Waiting for commands on 'gcode_movement'.")

    def send_request(self, msg):
        """
        Callback for when a G-code command is received. This method:
        1) Sends the command to the server at /rr_gcode.
        2) Waits (polling at 10 Hz) for a reply from /rr_reply.
        3) Publishes the reply to 'duet_publisher'.
        """
        rospy.loginfo("Received G-code command: '%s'", msg.data)
        try:
            # Clean and URL-encode the command
            command = msg.data.strip().replace("\r", "")
            command_encoded = urllib.parse.quote(command)
            full_url = f"{self.url}/rr_gcode?gcode={command_encoded}"
            rospy.loginfo("Sending command to: %s", full_url)
            
            # Send the command to the server
            requests.get(full_url)
            
            # Wait for the corresponding reply from the server
            reply = self.wait_for_reply()
            rospy.loginfo("Received reply: '%s'", reply)
            self.duet_pub.publish(reply)
        except Exception as e:
            rospy.logerr("Error sending command: %s", e)

    def wait_for_reply(self):
        """
        Wait for a reply from the /rr_reply endpoint.
        
        This function mimics the provided TypeScript functionality by issuing a GET
        request with a long timeout. It then trims the reply and returns it.
        """
        reply_url = f"{self.url}/rr_reply"
        try:
            # Use a long timeout (e.g., 30 seconds) to allow the server to return a reply
            response = requests.get(reply_url, timeout=30)
            reply = response.text.strip()
            return reply
        except Exception as e:
            rospy.logerr("Error fetching rr_reply: %s", e)
            return ""

    def handle_trigger(self, req):
        """
        Service callback that sends a GET request to the server's base URL.
        """
        try:
            start_time = time.time()
            response = requests.get(self.url)
            end_time = time.time()
            response_time = (end_time - start_time) * 1000  # in ms
            return TriggerResponse(success=True, message=f"{response.text} (Time taken: {response_time:.2f} ms)")
        except Exception as e:
            return TriggerResponse(success=False, message=str(e))
    
    def run(self):
        rospy.spin()

if __name__ == '__main__':
    try:
        node = HttpClientNode()
        node.run()
    except rospy.ROSInterruptException:
        pass
