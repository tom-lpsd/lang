(defmacro with-save-vars (vlist body)
  (let ((save (reduce #'(lambda (x y) (cons y (cons (symbol-value y) x))) (cons nil vlist))))
    `(let ((ret (,@body)))
       (setf ,@save)
       ret)))

