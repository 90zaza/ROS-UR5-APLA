import rospy
import fdm_msgs.msg
from std_msgs.msg import String
import sys
import json

class Communication:
    def __init__(self, gcodeInterpreter):     
        self.gcode_command_pub = rospy.Publisher('gcode_command', fdm_msgs.msg.GCodeCommand, queue_size=10)

        while self.gcode_command_pub.get_num_connections() == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'gcode_command'...")
            rospy.sleep(1)

        rospy.loginfo("Communication initialized. Publishing to /gcode_command")

        rospy.Subscriber("gcode_movement", fdm_msgs.msg.GCode, gcodeInterpreter.line_interpreter)

        return
    
    def publish_gcode_command(self, command):
        self.gcode_publisher.publish(command)

        return

class GCodeInterpreter:
    def __init__(self):
        self.comms = None
        self.seq_id = 0
        self.cmd_id = 1
        self.x_value = None
        self.y_value = None
        self.z_value = None
        self.f_value = None

    def set_comms(self, communication):
        self.comms = communication

    def line_interpreter(self, gcode_msg):
        for line in gcode_msg.lines:
            gcodeCommand_msg = fdm_msgs.msg.GCodeCommand()
            gcodeCommand_msg.cmd_id = self.cmd_id
            parts = line.split(";", 1)
            comment = parts[1].strip() if len(parts) > 1 else ""
            command = parts[0].strip()
            if comment == "End of GCode":
                gcodeCommand_msg.is_final = True
                self.comms.publish_gcode_command(gcodeCommand_msg)
            if len(command) == 0:
                self.cmd_id += 1
                return
            
            gcodeCommand_msg.seq_id = self.seq_id
            parameters = command.split()
            printing_command = []

            for param in parameters:
                if param[0]("X"):
                    gcodeCommand_msg.x = float(param[1:])
                    gcodeCommand_msg.has_movement = True
                elif param[0]("Y"):
                    gcodeCommand_msg.y = float(param[1:])
                    gcodeCommand_msg.has_movement = True
                elif param[0]("Z"):
                    gcodeCommand_msg.z = float(param[1:])
                    gcodeCommand_msg.has_movement = True
                elif param[0]("F"):
                    gcodeCommand_msg.f = float(param[1:])
                    gcodeCommand_msg.has_movement = True
                else:
                    printing_command.append(param)

            if len(printing_command) > 0:
                gcodeCommand_msg.printing_command = " ".join(printing_command) + " F" + str(gcodeCommand_msg.f)
                gcodeCommand_msg.has_printing = True
            
            self.seq_id += 1
            self.comms.publish_gcode_command(gcodeCommand_msg)
        
def main():
    rospy.init_node('gcode_interpreter', anonymous=True)

    gcodeInterpreter = GCodeInterpreter()
    comms = Communication(gcodeInterpreter)
    gcodeInterpreter.set_comms(comms)
    
    rospy.spin()

if __name__ == '__main__':
    main()