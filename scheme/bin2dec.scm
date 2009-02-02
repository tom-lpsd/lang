(define (bin2dec xs)
  (define (iter msb remain accum)
    (let ((ans (+ msb (* 2 accum))))
      (if (null? remain)
	  ans
	  (iter (car remain) (cdr remain) ans))))
  (iter (car xs) (cdr xs) 0))
