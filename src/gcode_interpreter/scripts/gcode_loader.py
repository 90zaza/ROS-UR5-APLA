import rospy
from std_msgs.msg import String
import sys
import json

class topicPublisher:
    def __init__(self):
        rospy.init_node('gcode_publisher', anonymous=True)
        
        self.movement_pub = rospy.Publisher('gcode_movement', String, queue_size=10)
        self.printing_pub = rospy.Publisher('gcode_printing', String, queue_size=10)

        # Wait for the client node (or any subscriber) to connect on gcode_movement
        while (self.movement_pub.get_num_connections() or self.printing_pub.get_num_connections()) == 0:
            rospy.logwarn("Waiting for subscribers to connect on 'gcode_movement' or 'gcode_printing'...")
            rospy.sleep(1)

        return


    def publish_gcode_lines(self, movementCommand, printingCommand):
        rospy.loginfo(f"Publishing: {movementCommand} on 'gcode_movement'")
        rospy.loginfo(f"Publishing: {printingCommand} on 'gcode_printing'")

        self.movement_pub.publish(movementCommand)
        self.printing_pub.publish(printingCommand)

        return

class gcodeInterpreter:
    def __init__(self):
        self.x_value = None
        self.y_value = None
        self.z_value = None
        self.f_value = None

    def line_interpreter(self, line, command_number, line_number):
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
        
        if xyz_found:
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


    def gcode_parser(self, file_path):
        try:
            command_number = 0
            with open(file_path, 'r') as file:
                for line_number, line in enumerate(file, start=1):
                    command = line.strip()
                    if not command:
                        continue
                    
                    command_number += 1
                    print('here')
                    movementCommand, printingCommand = self.line_interpreter(command, command_number, line_number)
                    publisher.publish_gcode_lines(movementCommand, printingCommand)
                    
            rospy.loginfo("Finished processing G-code file.")
        except Exception as e:
            rospy.logerr(f"Error reading file: {e}")

        return

if __name__ == '__main__':
    publisher = topicPublisher()
    interpreter = gcodeInterpreter()

    try:
        if len(sys.argv) < 2:
            rospy.logerr("Usage: rosrun gcode_interpreter gcode_loader <file.gcode>")
            sys.exit(1)
        
        gcode_file_path = sys.argv[1]
        interpreter.gcode_parser(gcode_file_path)
    except rospy.ROSInterruptException:
        pass
