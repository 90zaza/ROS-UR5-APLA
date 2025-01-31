import rospy
import requests
import time
from std_msgs.msg import String
from std_srvs.srv import Trigger, TriggerResponse

class HttpClientNode:
    def __init__(self):
        rospy.init_node('http_client_node', anonymous=True)
        self.url = rospy.get_param('~server_url', 'http://172.19.126.242')
        
        # self.command_sub = rospy.Subscriber('http_command', String, self.send_request)
        self.response_pub = rospy.Publisher('http_response', String, queue_size=10)
        self.server = rospy.Service('trigger_request', Trigger, self.handle_trigger)
        
        rospy.loginfo("HTTP Client Node Started. Listening for commands.")
    
    def send_request(self, data):
        try:
            start_time = time.time()
            response = requests.get(f"{self.url}/rr_gcode?gcode={data}")
            end_time = time.time()
            response_time = (end_time - start_time) * 1000
            rospy.loginfo(f"Received response: {response.text} in {response_time:.2f}ms")
            self.response_pub.publish(f"Received response: {response.text} in {response_time:.2f}ms")
        except Exception as e:
            rospy.logerr(f"HTTP Request failed: {e}")
    
    def handle_trigger(self, req):
        try:
            response = requests.get(self.url)
            return TriggerResponse(success=True, message=response.text)
        except Exception as e:
            return TriggerResponse(success=False, message=str(e))
    
    def run(self):
        while not rospy.is_shutdown():
            user_input = input("Enter command to send: ")
            self.send_request(user_input)
        
if __name__ == '__main__':
    try:
        node = HttpClientNode()
        node.run()
    except rospy.ROSInterruptException:
        pass
