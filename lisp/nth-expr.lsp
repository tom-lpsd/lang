(defmacro nth-expr (n &rest exps)
  (nth (- n 1) exps))

