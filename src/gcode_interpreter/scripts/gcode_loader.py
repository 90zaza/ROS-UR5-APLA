import rospy
import fdm_msgs.msg
from std_msgs.msg import String
import sys
import json

class Communication:
    def __init__(self):
        rospy.init_node('gcode_interpreter', anonymous=True)
        
        self.gcode_command_pub = rospy.Publisher('gcode_command', fdm_msgs.msg.GCodeCommand, queue_size=10)

        while self.gcode_command_pub.get_num_connections() == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'gcode_command'...")
            rospy.sleep(1)

        rospy.loginfo("Communication initialized. Publishing to /gcode_command")

        return
    
    def subscriber(self, gcodeInterpreter):
        rospy.Subscriber("gcode_movement", fdm_msgs.msg.GCode, gcodeInterpreter.line_interpreter)

        rospy.spin()

    def publish_gcode_command(self, command):
        gcodeCommand_msg = fdm_msgs.msg.GCodeCommand()
        gcodeCommand_msg.seq_id = command['seq_id']
        #and more
        self.gcode_publisher.publish(gcodeCommand_msg)

        return

class gcodeInterpreter:
    def __init__(self, comms):
        self.comms = comms
        self.x_value = None
        self.y_value = None
        self.z_value = None
        self.f_value = None

    def line_interpreter(self, gcode_msg):
        # Split the comment and command parts
        parts = line.split(";", 1)
        comment = parts[1].strip() if len(parts) > 1 else ""
        
        # Extract parameters
        command_part = parts[0].strip()
        parameters = command_part.split()

        for param in parameters:
            if param.startswith("F"):
                self.f_value = float(param[1:])
        
        xyz_found = False
        remaining_params = []
        for param in parameters:
            if param.startswith("X"):
                self.x_value = float(param[1:])
                xyz_found = True
            elif param.startswith("Y"):
                self.y_value = float(param[1:])
                xyz_found = True
            elif param.startswith("Z"):
                self.z_value = float(param[1:])
                xyz_found = True
            else:
                remaining_params.append(param)
        
        printing_string = " ".join(remaining_params)
        
        if xyz_found or comment == "End of Gcode":
            movementCommand = {
                "command": command_number,
                "line": line_number,
                "movement": {
                    "x": self.x_value,
                    "y": self.y_value,
                    "z": self.z_value,
                    "f": self.f_value
                },
                "comment": comment
            }
        else:
            movementCommand = None

        if printing_string.strip(): 
            printingCommand = {
                "command": command_number,
                "line": line_number,
                "printing": printing_string,
                "comment": comment
            }
        else:
            printingCommand = None
        
        return json.dumps(movementCommand), json.dumps(printingCommand)

def main():
    comms = Communication()
    gcodeInterpreter = gcodeInterpreter(comms)
    comms.subscriber(gcodeInterpreter)

if __name__ == '__main__':
    main()