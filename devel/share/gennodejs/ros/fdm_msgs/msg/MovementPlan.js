// Auto-generated. Do not edit!

// (in-package fdm_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let moveit_msgs = _finder('moveit_msgs');

//-----------------------------------------------------------

class MovementPlan {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.seq_ids = null;
      this.execution_times = null;
      this.trajectory = null;
    }
    else {
      if (initObj.hasOwnProperty('seq_ids')) {
        this.seq_ids = initObj.seq_ids
      }
      else {
        this.seq_ids = [];
      }
      if (initObj.hasOwnProperty('execution_times')) {
        this.execution_times = initObj.execution_times
      }
      else {
        this.execution_times = [];
      }
      if (initObj.hasOwnProperty('trajectory')) {
        this.trajectory = initObj.trajectory
      }
      else {
        this.trajectory = new moveit_msgs.msg.RobotTrajectory();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MovementPlan
    // Serialize message field [seq_ids]
    bufferOffset = _arraySerializer.int32(obj.seq_ids, buffer, bufferOffset, null);
    // Serialize message field [execution_times]
    bufferOffset = _arraySerializer.float64(obj.execution_times, buffer, bufferOffset, null);
    // Serialize message field [trajectory]
    bufferOffset = moveit_msgs.msg.RobotTrajectory.serialize(obj.trajectory, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MovementPlan
    let len;
    let data = new MovementPlan(null);
    // Deserialize message field [seq_ids]
    data.seq_ids = _arrayDeserializer.int32(buffer, bufferOffset, null)
    // Deserialize message field [execution_times]
    data.execution_times = _arrayDeserializer.float64(buffer, bufferOffset, null)
    // Deserialize message field [trajectory]
    data.trajectory = moveit_msgs.msg.RobotTrajectory.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.seq_ids.length;
    length += 8 * object.execution_times.length;
    length += moveit_msgs.msg.RobotTrajectory.getMessageSize(object.trajectory);
    return length + 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'fdm_msgs/MovementPlan';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'bb27415c930ac47c69fa82e8b7dc0ccd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # MovementPlan.msg
    int32[] seq_ids  # Sequence IDs to match each movement command
    float64[] execution_times  # Corresponding execution times
    moveit_msgs/RobotTrajectory trajectory  # Using an external message type
    
    ================================================================================
    MSG: moveit_msgs/RobotTrajectory
    trajectory_msgs/JointTrajectory joint_trajectory
    trajectory_msgs/MultiDOFJointTrajectory multi_dof_joint_trajectory
    
    ================================================================================
    MSG: trajectory_msgs/JointTrajectory
    Header header
    string[] joint_names
    JointTrajectoryPoint[] points
    
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    ================================================================================
    MSG: trajectory_msgs/JointTrajectoryPoint
    # Each trajectory point specifies either positions[, velocities[, accelerations]]
    # or positions[, effort] for the trajectory to be executed.
    # All specified values are in the same order as the joint names in JointTrajectory.msg
    
    float64[] positions
    float64[] velocities
    float64[] accelerations
    float64[] effort
    duration time_from_start
    
    ================================================================================
    MSG: trajectory_msgs/MultiDOFJointTrajectory
    # The header is used to specify the coordinate frame and the reference time for the trajectory durations
    Header header
    
    # A representation of a multi-dof joint trajectory (each point is a transformation)
    # Each point along the trajectory will include an array of positions/velocities/accelerations
    # that has the same length as the array of joint names, and has the same order of joints as 
    # the joint names array.
    
    string[] joint_names
    MultiDOFJointTrajectoryPoint[] points
    
    ================================================================================
    MSG: trajectory_msgs/MultiDOFJointTrajectoryPoint
    # Each multi-dof joint can specify a transform (up to 6 DOF)
    geometry_msgs/Transform[] transforms
    
    # There can be a velocity specified for the origin of the joint 
    geometry_msgs/Twist[] velocities
    
    # There can be an acceleration specified for the origin of the joint 
    geometry_msgs/Twist[] accelerations
    
    duration time_from_start
    
    ================================================================================
    MSG: geometry_msgs/Transform
    # This represents the transform between two coordinate frames in free space.
    
    Vector3 translation
    Quaternion rotation
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: geometry_msgs/Twist
    # This expresses velocity in free space broken into its linear and angular parts.
    Vector3  linear
    Vector3  angular
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MovementPlan(null);
    if (msg.seq_ids !== undefined) {
      resolved.seq_ids = msg.seq_ids;
    }
    else {
      resolved.seq_ids = []
    }

    if (msg.execution_times !== undefined) {
      resolved.execution_times = msg.execution_times;
    }
    else {
      resolved.execution_times = []
    }

    if (msg.trajectory !== undefined) {
      resolved.trajectory = moveit_msgs.msg.RobotTrajectory.Resolve(msg.trajectory)
    }
    else {
      resolved.trajectory = new moveit_msgs.msg.RobotTrajectory()
    }

    return resolved;
    }
};

module.exports = MovementPlan;
