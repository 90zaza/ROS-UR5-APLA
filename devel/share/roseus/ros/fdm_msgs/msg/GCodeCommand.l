;; Auto-generated. Do not edit!


(when (boundp 'fdm_msgs::GCodeCommand)
  (if (not (find-package "FDM_MSGS"))
    (make-package "FDM_MSGS"))
  (shadow 'GCodeCommand (find-package "FDM_MSGS")))
(unless (find-package "FDM_MSGS::GCODECOMMAND")
  (make-package "FDM_MSGS::GCODECOMMAND"))

(in-package "ROS")
;;//! \htmlinclude GCodeCommand.msg.html


(defclass fdm_msgs::GCodeCommand
  :super ros::object
  :slots (_seq_id _cmd_id _x _y _z _b _f _e _printing_command _has_movement _has_printing _has_extrusion _is_final ))

(defmethod fdm_msgs::GCodeCommand
  (:init
   (&key
    ((:seq_id __seq_id) 0)
    ((:cmd_id __cmd_id) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:b __b) 0.0)
    ((:f __f) 0.0)
    ((:e __e) 0.0)
    ((:printing_command __printing_command) "")
    ((:has_movement __has_movement) nil)
    ((:has_printing __has_printing) nil)
    ((:has_extrusion __has_extrusion) nil)
    ((:is_final __is_final) nil)
    )
   (send-super :init)
   (setq _seq_id (round __seq_id))
   (setq _cmd_id (round __cmd_id))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _b (float __b))
   (setq _f (float __f))
   (setq _e (float __e))
   (setq _printing_command (string __printing_command))
   (setq _has_movement __has_movement)
   (setq _has_printing __has_printing)
   (setq _has_extrusion __has_extrusion)
   (setq _is_final __is_final)
   self)
  (:seq_id
   (&optional __seq_id)
   (if __seq_id (setq _seq_id __seq_id)) _seq_id)
  (:cmd_id
   (&optional __cmd_id)
   (if __cmd_id (setq _cmd_id __cmd_id)) _cmd_id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:f
   (&optional __f)
   (if __f (setq _f __f)) _f)
  (:e
   (&optional __e)
   (if __e (setq _e __e)) _e)
  (:printing_command
   (&optional __printing_command)
   (if __printing_command (setq _printing_command __printing_command)) _printing_command)
  (:has_movement
   (&optional (__has_movement :null))
   (if (not (eq __has_movement :null)) (setq _has_movement __has_movement)) _has_movement)
  (:has_printing
   (&optional (__has_printing :null))
   (if (not (eq __has_printing :null)) (setq _has_printing __has_printing)) _has_printing)
  (:has_extrusion
   (&optional (__has_extrusion :null))
   (if (not (eq __has_extrusion :null)) (setq _has_extrusion __has_extrusion)) _has_extrusion)
  (:is_final
   (&optional (__is_final :null))
   (if (not (eq __is_final :null)) (setq _is_final __is_final)) _is_final)
  (:serialization-length
   ()
   (+
    ;; int32 _seq_id
    4
    ;; int32 _cmd_id
    4
    ;; float64 _x
    8
    ;; float64 _y
    8
    ;; float64 _z
    8
    ;; float64 _b
    8
    ;; float64 _f
    8
    ;; float64 _e
    8
    ;; string _printing_command
    4 (length _printing_command)
    ;; bool _has_movement
    1
    ;; bool _has_printing
    1
    ;; bool _has_extrusion
    1
    ;; bool _is_final
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _seq_id
       (write-long _seq_id s)
     ;; int32 _cmd_id
       (write-long _cmd_id s)
     ;; float64 _x
       (sys::poke _x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _y
       (sys::poke _y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _z
       (sys::poke _z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _b
       (sys::poke _b (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _f
       (sys::poke _f (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _e
       (sys::poke _e (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _printing_command
       (write-long (length _printing_command) s) (princ _printing_command s)
     ;; bool _has_movement
       (if _has_movement (write-byte -1 s) (write-byte 0 s))
     ;; bool _has_printing
       (if _has_printing (write-byte -1 s) (write-byte 0 s))
     ;; bool _has_extrusion
       (if _has_extrusion (write-byte -1 s) (write-byte 0 s))
     ;; bool _is_final
       (if _is_final (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _seq_id
     (setq _seq_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _cmd_id
     (setq _cmd_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _x
     (setq _x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _y
     (setq _y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _z
     (setq _z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _b
     (setq _b (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _f
     (setq _f (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _e
     (setq _e (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _printing_command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _printing_command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _has_movement
     (setq _has_movement (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _has_printing
     (setq _has_printing (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _has_extrusion
     (setq _has_extrusion (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _is_final
     (setq _is_final (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get fdm_msgs::GCodeCommand :md5sum-) "352c65e2dbd785cfb0a63fed83c40bb7")
(setf (get fdm_msgs::GCodeCommand :datatype-) "fdm_msgs/GCodeCommand")
(setf (get fdm_msgs::GCodeCommand :definition-)
      "# GCodeCommand.msg
int32 seq_id  # Unique ID to maintain execution order
int32 cmd_id  # Unique ID referencing the line-number in the original .gcode file
float64 x # Position in mm
float64 y # Position in mm
float64 z # Position in mm
float64 b # Orientation in rad
float64 f # Speed of movement in mm/min
float64 e # Relative amount of filament in mm
string printing_command  # Raw gCode like \"M82\"
bool has_movement  # True if there is a movement command
bool has_printing  # True if there is a printing command
bool has_extrusion # True if there is an extrusion command
bool is_final # True if it is the final command
")



(provide :fdm_msgs/GCodeCommand "352c65e2dbd785cfb0a63fed83c40bb7")


