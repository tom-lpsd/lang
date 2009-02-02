(defstruct tst
  elt (l nil) (m nil) (r nil))

(defun copy-tst (tst)
  (and tst
       (make-tst :elt (tst-elt tst)
		 :l   (copy-tst (tst-l tst))
		 :m   (copy-tst (tst-m tst))
		 :r   (copy-tst (tst-r tst)))))

(defun tst-find (obj tst)
  (if (null tst)
      nil
    (if (eql obj (tst-elt tst))
	tst 
      (or (tst-find obj (tst-l tst))
	  (tst-find obj (tst-m tst))
	  (tst-find obj (tst-r tst))))))
