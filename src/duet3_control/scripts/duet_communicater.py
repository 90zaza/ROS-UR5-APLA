import rospy
import json
import time
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
        self.url = "http://172.19.126.242"
        self.url_reply = f"{self.url}/rr_reply"
        self.url_model = f"{self.url}/rr_model?flags=d99fno"
        self.url_heat = f"{self.url}/rr_model?key=heat"
        self.url_extrusion = f"{self.url}/rr_model?key=state"
        self.comms = comms
        
    def sendCommand(self, msg):
        print(f"Received G-code command: {msg.printing_command}")
        try:
            command = msg.printing_command.strip().replace("\r", "")
            # command = msg.replace("\r", "")
            command_encoded = urllib.parse.quote(command)
            full_url = f"{self.url}/rr_gcode?gcode={command_encoded}"
            rospy.loginfo("Sending command to: %s", full_url)
            
            response = requests.get(full_url).text.strip()
            if not msg.has_movement:
                self.askReply(msg)

        except Exception as e:
            rospy.logerr("Error sending command: %s", e)

    def askReply(self, msg): 
        try:
            param = msg.printing_command.split(" ")
            if param[0] == "M109":
                self.waitForTemp(float(param[1][1:]))
                return

            if param[0] == "G1":
                self.waitForExtrusion()
                return
            
            response_reply = requests.get(self.url_reply)
            reply = response_reply.text.strip()
            print(f'Got a reply! It is: {reply}')
            self.comms.publish_duet_response("OK")
            return
        
        except Exception as e:
            rospy.logerr("Error fetching rr_reply: %s", e)
            return
        
    def waitForTemp(self, target_temp, heater_index = 0, tolerance = 2):
        try:
            stable_count = 0  # Count how many times the temperature is stable

            while True:
                response = requests.get(self.url_heat)
                model = response.json()

                heaters = model.get("result", {}).get("heaters", [])

                if not heaters:
                    print("No heater data available, retrying...")
                    time.sleep(1)
                    continue

                current_temp = heaters[heater_index].get("current", 0)
                active_temp = heaters[heater_index].get("active", 0)
                state = heaters[heater_index].get("state", "")

                print(f"Current temp: {current_temp}°C, Target: {active_temp}°C, State: {state}")

                # Check if current temperature is within tolerance of target
                if abs(current_temp - target_temp) <= tolerance:
                    stable_count += 1  # Increase counter if within range
                else:
                    stable_count = 0  # Reset if temperature fluctuates

                if stable_count >= 3:  # Ensure it's stable for 3 cycles (~6 sec)
                    print("Heater reached target temperature and is stable!")
                    self.comms.publish_duet_response("OK")
                    return

                time.sleep(2)  # Poll every 2 seconds

        except Exception as e:
            rospy.logerr(f"Error fetching heater status: {e}")

    def waitForExtrusion(self):
        try:
            while True:
                response_model = requests.get(self.url_extrusion)
                model = response_model.json()
                state = model.get("result", {}).get("status", {})

                if not state:
                    print("No status data available, retrying...")
                    time.sleep(1)
                    continue

                if state == "busy":
                    print(f"Got state {state}, checking again!")
                    time.sleep(0.1)
                    continue

                print(f"Got state {state}, continuing")
                self.comms.publish_duet_response("OK")
                return
        except Exception as e:
            rospy.logerr(f"Error fetching model status: {e}")
        return



def main():
    rospy.init_node('duetCommunicater', anonymous=True)

    comms = Communication()
    duetCommunicater = DuetCommunicater(comms)

    # gcodeMSG = input("Please enter the GCode command: ").strip()
    # duetCommunicater.sendCommand(gcodeMSG)

    comms.set_class_pointers(duetCommunicater)
    comms.set_subscribers()
    comms.wait_for_publishers()
    
    rospy.spin()

if __name__ == '__main__':
    main()