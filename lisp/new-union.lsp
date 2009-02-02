(defun new-union (x y)
  (reverse (new-union_ y x ())))

(defun new-union_ (x y acc)
  (if (or (null x) (null y))
    acc
    (new-union_ (cdr x) (cdr y) (adjoin (car x) (adjoin (car y) acc)))))

(mapcar #'(lambda (x) (format t "~A " x)) (new-union '(a b c) '(b a d)))

