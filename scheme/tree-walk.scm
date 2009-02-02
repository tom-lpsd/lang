(define (tree-walk walker proc tree)
  (walker (lambda (elt)
	    (if (list? elt)
		(tree-walk walker proc elt)
		(proc elt)))
	  tree))

(define (reverse-for-each proc lis)
  (for-each proc (reverse lis)))