(defun count-filter (key lst)
  (count-filter_ key lst '() 1))

(defun count-filter_ (key lst acc cnt)
  (if (null lst)
    (cons acc (cons key cnt))
    (if (eql (car lst) key)
      (count-filter_ key (cdr lst) acc (+ 1 cnt))
      (count-filter_ key (cdr lst) (cons (car lst) acc) cnt))))

(defun occurrences_ (lst)
  (if (null lst)
    nil
    (let ((res (count-filter (car lst) (cdr lst))))
      (cons (cdr res) (occurrences (car res)) ))))

(defun occurrences (lst)
  (sort (occurrences_ lst) #'(lambda (x y) (> (cdr x) (cdr y)))))

(mapcar #'(lambda (x) (format t "(~A . ~A) " (car x) (cdr x))) (occurrences '(a b a d a c d c a)))

