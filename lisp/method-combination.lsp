(defclass speaker () ())

(defmethod speak ((s speaker) string)
  (format t "~A" string))

(defclass intellectual (speaker) ())

(defmethod speak :before ((i intellectual) string)
  (princ "Perhaps "))

(defmethod speak :after ((i intellectual) string)
  (princ " in some sense"))

(defclass yaspeaker (speaker) ())
