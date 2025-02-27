// Auto-generated. Do not edit!

// (in-package fdm_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class GCodeCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.seq_id = null;
      this.cmd_id = null;
      this.x = null;
      this.y = null;
      this.z = null;
      this.f = null;
      this.printing_command = null;
      this.has_movement = null;
      this.has_printing = null;
      this.is_final = null;
    }
    else {
      if (initObj.hasOwnProperty('seq_id')) {
        this.seq_id = initObj.seq_id
      }
      else {
        this.seq_id = 0;
      }
      if (initObj.hasOwnProperty('cmd_id')) {
        this.cmd_id = initObj.cmd_id
      }
      else {
        this.cmd_id = 0;
      }
      if (initObj.hasOwnProperty('x')) {
        this.x = initObj.x
      }
      else {
        this.x = 0.0;
      }
      if (initObj.hasOwnProperty('y')) {
        this.y = initObj.y
      }
      else {
        this.y = 0.0;
      }
      if (initObj.hasOwnProperty('z')) {
        this.z = initObj.z
      }
      else {
        this.z = 0.0;
      }
      if (initObj.hasOwnProperty('f')) {
        this.f = initObj.f
      }
      else {
        this.f = 0.0;
      }
      if (initObj.hasOwnProperty('printing_command')) {
        this.printing_command = initObj.printing_command
      }
      else {
        this.printing_command = '';
      }
      if (initObj.hasOwnProperty('has_movement')) {
        this.has_movement = initObj.has_movement
      }
      else {
        this.has_movement = false;
      }
      if (initObj.hasOwnProperty('has_printing')) {
        this.has_printing = initObj.has_printing
      }
      else {
        this.has_printing = false;
      }
      if (initObj.hasOwnProperty('is_final')) {
        this.is_final = initObj.is_final
      }
      else {
        this.is_final = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GCodeCommand
    // Serialize message field [seq_id]
    bufferOffset = _serializer.int32(obj.seq_id, buffer, bufferOffset);
    // Serialize message field [cmd_id]
    bufferOffset = _serializer.int32(obj.cmd_id, buffer, bufferOffset);
    // Serialize message field [x]
    bufferOffset = _serializer.float64(obj.x, buffer, bufferOffset);
    // Serialize message field [y]
    bufferOffset = _serializer.float64(obj.y, buffer, bufferOffset);
    // Serialize message field [z]
    bufferOffset = _serializer.float64(obj.z, buffer, bufferOffset);
    // Serialize message field [f]
    bufferOffset = _serializer.float64(obj.f, buffer, bufferOffset);
    // Serialize message field [printing_command]
    bufferOffset = _serializer.string(obj.printing_command, buffer, bufferOffset);
    // Serialize message field [has_movement]
    bufferOffset = _serializer.bool(obj.has_movement, buffer, bufferOffset);
    // Serialize message field [has_printing]
    bufferOffset = _serializer.bool(obj.has_printing, buffer, bufferOffset);
    // Serialize message field [is_final]
    bufferOffset = _serializer.bool(obj.is_final, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GCodeCommand
    let len;
    let data = new GCodeCommand(null);
    // Deserialize message field [seq_id]
    data.seq_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [cmd_id]
    data.cmd_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [x]
    data.x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [y]
    data.y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [z]
    data.z = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [f]
    data.f = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [printing_command]
    data.printing_command = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [has_movement]
    data.has_movement = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [has_printing]
    data.has_printing = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [is_final]
    data.is_final = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.printing_command);
    return length + 47;
  }

  static datatype() {
    // Returns string type for a message object
    return 'fdm_msgs/GCodeCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'adfc96e244d9dd15b863f79af34eb1fe';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # GCodeCommand.msg
    int32 seq_id  # Unique ID to maintain execution order
    int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file
    float64 x
    float64 y
    float64 z
    float64 f  # Speed of movement
    string printing_command  # Raw gCode like "M82"
    bool has_movement  # True if there is a movement command
    bool has_printing  # True if there is a printing command
    bool is_final # True if it is the final command
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GCodeCommand(null);
    if (msg.seq_id !== undefined) {
      resolved.seq_id = msg.seq_id;
    }
    else {
      resolved.seq_id = 0
    }

    if (msg.cmd_id !== undefined) {
      resolved.cmd_id = msg.cmd_id;
    }
    else {
      resolved.cmd_id = 0
    }

    if (msg.x !== undefined) {
      resolved.x = msg.x;
    }
    else {
      resolved.x = 0.0
    }

    if (msg.y !== undefined) {
      resolved.y = msg.y;
    }
    else {
      resolved.y = 0.0
    }

    if (msg.z !== undefined) {
      resolved.z = msg.z;
    }
    else {
      resolved.z = 0.0
    }

    if (msg.f !== undefined) {
      resolved.f = msg.f;
    }
    else {
      resolved.f = 0.0
    }

    if (msg.printing_command !== undefined) {
      resolved.printing_command = msg.printing_command;
    }
    else {
      resolved.printing_command = ''
    }

    if (msg.has_movement !== undefined) {
      resolved.has_movement = msg.has_movement;
    }
    else {
      resolved.has_movement = false
    }

    if (msg.has_printing !== undefined) {
      resolved.has_printing = msg.has_printing;
    }
    else {
      resolved.has_printing = false
    }

    if (msg.is_final !== undefined) {
      resolved.is_final = msg.is_final;
    }
    else {
      resolved.is_final = false
    }

    return resolved;
    }
};

module.exports = GCodeCommand;
