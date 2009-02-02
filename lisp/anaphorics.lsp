(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it ,then ,else)))

(defmacro awhen (test &body body)
  `(aif ,test (progn ,@body)))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))

(defmacro awhile (expr &body body)
  `(do ((it ,expr ,expr))
       ((not it))
     ,@body))

(defmacro aand (&rest args)
  (cond ((null args) t)
	((null (cdr args)) (car args))
	(t `(aif ,(car args) (aand ,@(cdr args))))))

(defmacro aif2 (test &optional then else)
  (let ((win (gensym)))
    `(multiple-value-bind (it ,win) ,test
       (if (or it ,win) ,then ,else))))

(defmacro awhen2 (test &body body)
  `(aif2 ,test
	 (progn ,@body)))

(defmacro awhile2 (test &body body)
  (let ((flag (gensym)))
    `(let ((,flag t))
       (while ,flag
	 (aif2 ,test
	       (progn ,@body)
	       (setq ,flag nil))))))

(defmacro acond2 (&rest clauses)
  (if (null clauses)
      nil
    (let ((cl1 (car clauses))
	  (val (gensym))
	  (win (gensym)))
      `(multiple-value-bind (,val ,win) ,(car cl1)
	 (if (or ,val ,win)
	     (let ((it ,val)) ,@(cdr cl1))
	   (acond2 ,@(cdr clauses)))))))
