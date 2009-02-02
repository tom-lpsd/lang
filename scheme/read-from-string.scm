(define (my-read-from-string str)
  (call-with-input-string str
    (lambda (in)
      (read in))))
