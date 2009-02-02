(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1))
	 (* 2 (f (- n 2)))
	 (* 3 (f (- n 3))))))


(define (f2 n)
  (define (iter a b c count)
    (if (= count n)
	a
	(iter (+ a (* 2 b) (* 3 c)) a b (+ count 1))))
  (iter 2 1 0 2))

(define (make-f-list n)
  (define (iter ls count)
    (if (= count n)
	ls
	(iter (cons (f count) ls) (+ count 1))))
  (reverse (iter '() 0)))
