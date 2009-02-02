(define (my-any-pred . args)
  (define (iter x preds)
    (and (not (null? preds))
	 (if ((car preds) x)
	     #t
	     (iter x (cdr preds)))))
    (lambda (x) (iter x args)))
