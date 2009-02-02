(define (my-write-to-string obj)
  (call-with-output-string 
    (lambda (out)
      (write obj out))))
