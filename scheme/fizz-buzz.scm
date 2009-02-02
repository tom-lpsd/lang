(use srfi-1)

(define (check-num x)
  (cond [(= (modulo x 15) 0) 'FizzBuzz]
	[(= (modulo x 5) 0) 'Buzz]
	[(= (modulo x 3) 0) 'Fizz]
	[else x]))

(define (fizz-buzz check max)
  (map check (iota max 1)))
