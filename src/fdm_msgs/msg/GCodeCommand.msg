# GCodeCommand.msg
int32 seq_id  # Unique ID to maintain execution order
int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file
float64 x # Position in mm
float64 y # Position in mm
float64 z # Position in mm
float64 b # Orientation in rad
float64 f  # Speed of movement in mm/min
string printing_command  # Raw gCode like "M82"
bool has_movement  # True if there is a movement command
bool has_printing  # True if there is a printing command
bool is_final # True if it is the final command