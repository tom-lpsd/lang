(define frozen #f)
(define x 0)

(define (foo)
  (call/cc (lambda (cc)
	     (set! frozen cc))))

(let ((y 0))
  (foo)
  (display '(1 2 3))
  (newline)
  (set! x (+ x 1)))

(frozen ())

