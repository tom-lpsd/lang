(defun pos+ (lst)
  (pos+_ lst 0))

(defun pos+_ (lst pos)
  (if (null lst)
    nil
    (cons (+ (car lst) pos) (pos+_ (cdr lst) (+ 1 pos)))))

(defun pos+2 (lst)
  (setf cnt 0
	result nil)
  (dolist (x lst)
    (setf result (cons (+ x cnt) result))
    (setf cnt (+ cnt 1)))
  (reverse result))

(defun seq (x y acc)
  (if (eq x y)
    (reverse acc)
    (seq (+ x 1) y (cons x acc))))

(defun pos+3 (lst)
  (mapcar #'+ lst (seq 0 (length lst) nil)))

(mapcar #'(lambda (x) (format t "~A " x)) (pos+ '(7 5 1 4)))
(format t "~%")
(mapcar #'(lambda (x) (format t "~A " x)) (pos+2 '(7 5 1 4)))
(format t "~%")
(mapcar #'(lambda (x) (format t "~A " x)) (pos+3 '(7 5 1 4)))

