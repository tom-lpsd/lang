(define (delete-1 elt lis . options)
  (let-optionals* 
   options ((cmp-fn equal?))
   (define (loop lis)
     (cond [(null? lis) '()]
	   [(cmp-fn elt (car lis)) (cdr lis)]
	   [else (cons (car lis) (loop (cdr lis)))]))
   (loop lis)))

(define (delete-1-ncp elt lis . options)
  (let-optionals*
   options ((cmp-fn equal?))
   (define (loop lis)
     (cond [(null? lis) '()]
	   [(cmp-fn elt (car lis)) (cdr lis)]
	   [else (if (eq? (loop (cdr lis)) (cdr lis))
		     lis
		     (cons (car lis) (loop (cdr lis))))]))
   (loop lis)))
