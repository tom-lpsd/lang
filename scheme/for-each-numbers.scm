(define (filter pred lis)
  (if (null? lis)
      lis
      (if (pred (car lis))
	  (cons (car lis) (filter pred (cdr lis)))
	  (filter pred (cdr lis)))))

(define (for-each-numbers proc lis)
  (for-each proc (filter number? lis)))

(define (map-numbers proc lis)
  (map proc (filter number? lis)))

(define (numbers-only walker)
  (lambda (proc lis)
    (walker proc (filter number? lis))))

(define (tree-walk walker proc tree)
  (walker (lambda (elt)
	    (if (list? elt)
		(tree-walk walker proc elt)
		(proc elt)))
	  tree))

(define (numbers-only-for-tree walker)
  (lambda (proc lis)
    (walker proc (tree-walk filter number? lis))))

(define (main args)
  (tree-walk (numbers-only-for-tree map) print 
	     '((1 2 3) a 39 (b 3 2))))
