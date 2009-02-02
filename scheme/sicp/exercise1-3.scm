(define (square x) (* x x))

(define (sum-of-square x y)
  (+ (square x) (square y)))

(define (select x y z)
  (if (< x y)
      (if (< x z)
	  (list y z) (list x y))
      (if (< y z)
	  (list x z) (list y x))))

(define (foo x y z)
  (if (< x y)
      (if (< x z)
	  (sum-of-square y z)
	  (sum-of-square x y))
      (if (< y z)
	  (sum-of-square x z)
	  (sum-of-square y x))))

(define (bar x y z)
  (apply sum-of-square (select x y z)))
