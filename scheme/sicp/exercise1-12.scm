(define (pascal n)
  (define (pascal-iter result count)
    (define (iter pas accum)
      (if (null? (cdr pas))
	  accum
	  (iter (cdr pas) (cons (+ (car pas) (cadr pas)) accum))))
    (if (= n count)
	result
	(cons 1 (iter (pascal-iter result (+ 1 count)) '(1)))))
  (pascal-iter '(1) 1))
