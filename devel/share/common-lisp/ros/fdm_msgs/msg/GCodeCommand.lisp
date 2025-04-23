; Auto-generated. Do not edit!


(cl:in-package fdm_msgs-msg)


;//! \htmlinclude GCodeCommand.msg.html

(cl:defclass <GCodeCommand> (roslisp-msg-protocol:ros-message)
  ((seq_id
    :reader seq_id
    :initarg :seq_id
    :type cl:integer
    :initform 0)
   (cmd_id
    :reader cmd_id
    :initarg :cmd_id
    :type cl:integer
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0)
   (b
    :reader b
    :initarg :b
    :type cl:float
    :initform 0.0)
   (f
    :reader f
    :initarg :f
    :type cl:float
    :initform 0.0)
   (e
    :reader e
    :initarg :e
    :type cl:float
    :initform 0.0)
   (printing_command
    :reader printing_command
    :initarg :printing_command
    :type cl:string
    :initform "")
   (has_movement
    :reader has_movement
    :initarg :has_movement
    :type cl:boolean
    :initform cl:nil)
   (has_printing
    :reader has_printing
    :initarg :has_printing
    :type cl:boolean
    :initform cl:nil)
   (has_extrusion
    :reader has_extrusion
    :initarg :has_extrusion
    :type cl:boolean
    :initform cl:nil)
   (is_final
    :reader is_final
    :initarg :is_final
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass GCodeCommand (<GCodeCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GCodeCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GCodeCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name fdm_msgs-msg:<GCodeCommand> is deprecated: use fdm_msgs-msg:GCodeCommand instead.")))

(cl:ensure-generic-function 'seq_id-val :lambda-list '(m))
(cl:defmethod seq_id-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:seq_id-val is deprecated.  Use fdm_msgs-msg:seq_id instead.")
  (seq_id m))

(cl:ensure-generic-function 'cmd_id-val :lambda-list '(m))
(cl:defmethod cmd_id-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:cmd_id-val is deprecated.  Use fdm_msgs-msg:cmd_id instead.")
  (cmd_id m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:x-val is deprecated.  Use fdm_msgs-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:y-val is deprecated.  Use fdm_msgs-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:z-val is deprecated.  Use fdm_msgs-msg:z instead.")
  (z m))

(cl:ensure-generic-function 'b-val :lambda-list '(m))
(cl:defmethod b-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:b-val is deprecated.  Use fdm_msgs-msg:b instead.")
  (b m))

(cl:ensure-generic-function 'f-val :lambda-list '(m))
(cl:defmethod f-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:f-val is deprecated.  Use fdm_msgs-msg:f instead.")
  (f m))

(cl:ensure-generic-function 'e-val :lambda-list '(m))
(cl:defmethod e-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:e-val is deprecated.  Use fdm_msgs-msg:e instead.")
  (e m))

(cl:ensure-generic-function 'printing_command-val :lambda-list '(m))
(cl:defmethod printing_command-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:printing_command-val is deprecated.  Use fdm_msgs-msg:printing_command instead.")
  (printing_command m))

(cl:ensure-generic-function 'has_movement-val :lambda-list '(m))
(cl:defmethod has_movement-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:has_movement-val is deprecated.  Use fdm_msgs-msg:has_movement instead.")
  (has_movement m))

(cl:ensure-generic-function 'has_printing-val :lambda-list '(m))
(cl:defmethod has_printing-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:has_printing-val is deprecated.  Use fdm_msgs-msg:has_printing instead.")
  (has_printing m))

(cl:ensure-generic-function 'has_extrusion-val :lambda-list '(m))
(cl:defmethod has_extrusion-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:has_extrusion-val is deprecated.  Use fdm_msgs-msg:has_extrusion instead.")
  (has_extrusion m))

(cl:ensure-generic-function 'is_final-val :lambda-list '(m))
(cl:defmethod is_final-val ((m <GCodeCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader fdm_msgs-msg:is_final-val is deprecated.  Use fdm_msgs-msg:is_final instead.")
  (is_final m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GCodeCommand>) ostream)
  "Serializes a message object of type '<GCodeCommand>"
  (cl:let* ((signed (cl:slot-value msg 'seq_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'cmd_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'b))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'f))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'e))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'printing_command))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'printing_command))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_movement) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_printing) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_extrusion) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_final) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GCodeCommand>) istream)
  "Deserializes a message object of type '<GCodeCommand>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'seq_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'cmd_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'b) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'f) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'e) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'printing_command) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'printing_command) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'has_movement) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'has_printing) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'has_extrusion) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'is_final) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GCodeCommand>)))
  "Returns string type for a message object of type '<GCodeCommand>"
  "fdm_msgs/GCodeCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GCodeCommand)))
  "Returns string type for a message object of type 'GCodeCommand"
  "fdm_msgs/GCodeCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GCodeCommand>)))
  "Returns md5sum for a message object of type '<GCodeCommand>"
  "352c65e2dbd785cfb0a63fed83c40bb7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GCodeCommand)))
  "Returns md5sum for a message object of type 'GCodeCommand"
  "352c65e2dbd785cfb0a63fed83c40bb7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GCodeCommand>)))
  "Returns full string definition for message of type '<GCodeCommand>"
  (cl:format cl:nil "# GCodeCommand.msg~%int32 seq_id  # Unique ID to maintain execution order~%int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file~%float64 x # Position in mm~%float64 y # Position in mm~%float64 z # Position in mm~%float64 b # Orientation in rad~%float64 f # Speed of movement in mm/min~%float64 e # Relative amount of filament in mm~%string printing_command  # Raw gCode like \"M82\"~%bool has_movement  # True if there is a movement command~%bool has_printing  # True if there is a printing command~%bool has_extrusion # True if there is an extrusion command~%bool is_final # True if it is the final command~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GCodeCommand)))
  "Returns full string definition for message of type 'GCodeCommand"
  (cl:format cl:nil "# GCodeCommand.msg~%int32 seq_id  # Unique ID to maintain execution order~%int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file~%float64 x # Position in mm~%float64 y # Position in mm~%float64 z # Position in mm~%float64 b # Orientation in rad~%float64 f # Speed of movement in mm/min~%float64 e # Relative amount of filament in mm~%string printing_command  # Raw gCode like \"M82\"~%bool has_movement  # True if there is a movement command~%bool has_printing  # True if there is a printing command~%bool has_extrusion # True if there is an extrusion command~%bool is_final # True if it is the final command~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GCodeCommand>))
  (cl:+ 0
     4
     4
     8
     8
     8
     8
     8
     8
     4 (cl:length (cl:slot-value msg 'printing_command))
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GCodeCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'GCodeCommand
    (cl:cons ':seq_id (seq_id msg))
    (cl:cons ':cmd_id (cmd_id msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
    (cl:cons ':b (b msg))
    (cl:cons ':f (f msg))
    (cl:cons ':e (e msg))
    (cl:cons ':printing_command (printing_command msg))
    (cl:cons ':has_movement (has_movement msg))
    (cl:cons ':has_printing (has_printing msg))
    (cl:cons ':has_extrusion (has_extrusion msg))
    (cl:cons ':is_final (is_final msg))
))
