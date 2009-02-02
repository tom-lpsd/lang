(defun showdots (lst)
  (if (atom lst)
    (format t "~A " lst)
    (progn
      (format t "(~A . " (car lst))
      (showdots_ (cdr lst) 0))))

(defun showdots_ (lst n)
  (if (null lst)
    (progn
      (format t "NIL")
      (do ((i 0 (+ i 1)))
	((> i n) nil)
	(format t ")")))
    (progn
      (format t "(")
      (showdots (car lst))
      (format t " . ")
      (showdots_ (cdr lst) (+ 1 n)))))

(showdots '(a b c))
(format t "~%")
(showdots '(a b c (a b)))
(format t "~%")
(showdots '((a d e) b c (a b)))
