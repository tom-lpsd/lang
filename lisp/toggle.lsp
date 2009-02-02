(defmacro toggle (&rest args)
  `(progn
     ,@(mapcar #'(lambda (a) `(toggle2 ,a))
	       args)))

(define-modify-macro toggle2 () not)
