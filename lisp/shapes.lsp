(defclass rectangle ()
 (height width))

(defclass circle ()
  (radius))

(defclass colored ()
  (color))

(defclass colored-circle (circle colored)
 ())

(defmethod area ((x rectangle))
 (* (slot-value x 'height) (slot-value x 'width)))

(defmethod area ((x circle))
 (* pi (expt (slot-value x 'radius) 2)))

  
