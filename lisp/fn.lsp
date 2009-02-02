(defmacro fn (expr) `#',(rbuild expr))

(defun rbuild (expr)
  (if (or (atom expr) (eq (car expr) 'lambda))
      expr
    (if (eq (car expr) 'compose)
	(build-compose (cdr expr))
      (build-call (car expr) (cdr expr)))))

(defun build-call (op fns)
  (let ((g (gensym)))
    `(lambda (,g)
       (,op ,@(mapcar #'(lambda (f)
			  `(,(rbuild f) ,g))
		      fns)))))

(defun build-compose (fns)
  (let ((g (gensym)))
    `(lambda (,g)
       ,(labels ((rec (fns)
		      (if fns
			  `(,(rbuild (car fns))
			    ,(rec (cdr fns)))
			g)))
	  (rec fns)))))

