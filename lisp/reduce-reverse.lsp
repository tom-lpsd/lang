(defun reduce-reverse (lst)
  (reduce #'(lambda (a b) (cons b a)) lst :initial-value nil))
