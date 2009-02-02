(defmacro ntimes (n &rest body)
  (let ((g (gensym))
	(h (gensym)))
    `(labels ((,g (,h) 
		  (if (/= 1 ,h) 
		    (progn ,@body (,g (- ,h 1)))
		    (progn ,@body))))
	      (,g ,n))))

