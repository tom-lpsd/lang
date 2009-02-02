(defun reduce-copy-list (lst)
  (reduce #'cons lst :from-end t :initial-value nil))
