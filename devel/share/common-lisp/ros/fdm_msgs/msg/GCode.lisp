; Auto-generated. Do not edit!


(cl:in-package fdm_msgs-msg)


;//! \htmlinclude GCode.msg.html

(cl:defclass <GCode> (roslisp-msg-protocol:ros-message)
  ((lines
    :reader lines
    :initarg :lines
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass GCode (<GCode>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GCode>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GCode)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name fdm_msgs-msg:<GCode> is deprecated: use fdm_msgs-msg:GCode instead.")))

(cl:ensure-generic-function 'lines-val :lambda-list '(m))
(cl:defmethod lines-val ((m <GCode>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:lines-val is deprecated.  Use fdm_msgs-msg:lines instead.")
  (lines m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GCode>) ostream)
  "Serializes a message object of type '<GCode>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'lines))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'lines))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GCode>) istream)
  "Deserializes a message object of type '<GCode>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'lines) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'lines)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GCode>)))
  "Returns string type for a message object of type '<GCode>"
  "fdm_msgs/GCode")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GCode)))
  "Returns string type for a message object of type 'GCode"
  "fdm_msgs/GCode")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GCode>)))
  "Returns md5sum for a message object of type '<GCode>"
  "24da4e51d34c7073cb6bb805aa7f3bef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GCode)))
  "Returns md5sum for a message object of type 'GCode"
  "24da4e51d34c7073cb6bb805aa7f3bef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GCode>)))
  "Returns full string definition for message of type '<GCode>"
  (cl:format cl:nil "# GCode.msg~%string[] lines  # List of all gCode lines~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GCode)))
  "Returns full string definition for message of type 'GCode"
  (cl:format cl:nil "# GCode.msg~%string[] lines  # List of all gCode lines~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GCode>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'lines) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GCode>))
  "Converts a ROS message object to a list"
  (cl:list 'GCode
    (cl:cons ':lines (lines msg))
))
