;; Auto-generated. Do not edit!


(when (boundp 'fdm_msgs::GCode)
  (if (not (find-package "FDM_MSGS"))
    (make-package "FDM_MSGS"))
  (shadow 'GCode (find-package "FDM_MSGS")))
(unless (find-package "FDM_MSGS::GCODE")
  (make-package "FDM_MSGS::GCODE"))

(in-package "ROS")
;;//! \htmlinclude GCode.msg.html


(defclass fdm_msgs::GCode
  :super ros::object
  :slots (_lines ))

(defmethod fdm_msgs::GCode
  (:init
   (&key
    ((:lines __lines) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _lines __lines)
   self)
  (:lines
   (&optional __lines)
   (if __lines (setq _lines __lines)) _lines)
  (:serialization-length
   ()
   (+
    ;; string[] _lines
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _lines)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string[] _lines
     (write-long (length _lines) s)
     (dolist (elem _lines)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string[] _lines
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _lines (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _lines i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get fdm_msgs::GCode :md5sum-) "24da4e51d34c7073cb6bb805aa7f3bef")
(setf (get fdm_msgs::GCode :datatype-) "fdm_msgs/GCode")
(setf (get fdm_msgs::GCode :definition-)
      "# GCode.msg
string[] lines  # List of all gCode lines
")



(provide :fdm_msgs/GCode "24da4e51d34c7073cb6bb805aa7f3bef")


