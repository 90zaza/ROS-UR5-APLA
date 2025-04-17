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

class GCode {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.lines = null;
    }
    else {
      if (initObj.hasOwnProperty('lines')) {
        this.lines = initObj.lines
      }
      else {
        this.lines = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GCode
    // Serialize message field [lines]
    bufferOffset = _arraySerializer.string(obj.lines, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GCode
    let len;
    let data = new GCode(null);
    // Deserialize message field [lines]
    data.lines = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.lines.forEach((val) => {
      length += 4 + _getByteLength(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'fdm_msgs/GCode';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '24da4e51d34c7073cb6bb805aa7f3bef';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # GCode.msg
    string[] lines  # List of all gCode lines
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GCode(null);
    if (msg.lines !== undefined) {
      resolved.lines = msg.lines;
    }
    else {
      resolved.lines = []
    }

    return resolved;
    }
};

module.exports = GCode;
