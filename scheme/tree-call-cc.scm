(define (dft tree)
  (cond ((null? tree) ())
	((not (pair? tree)) (write tree))
	(else (dft (car tree))
	      (dft (cdr tree)))))

(define *saved* ())

(define (dft-node tree)
  (cond ((null? tree) (restart))
	((not (pair? tree)) tree)
	(else (call/cc
	       (lambda (cc)
		 (set! *saved*
		       (cons (lambda ()
			       (cc (dft-node (cdr tree))))
			     *saved*))
		 (dft-node (car tree)))))))

(define (restart)
  (if (null? *saved*)
      'done
      (let ((cont (car *saved*)))
	(set! *saved* (cdr *saved*))
	(cont))))

(define (dft2 tree)
  (set! *saved* ())
  (let ((node (dft-node tree)))
    (cond ((eq? node 'done) ())
	  (else (write node)
		(restart)))))
