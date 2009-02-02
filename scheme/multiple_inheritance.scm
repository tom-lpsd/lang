(define-class <foo> () ((foo :init-keyword :foo)))
(define-class <bar> () ((bar :init-keyword :bar)))
(define-class <baz> (<foo> <bar>) (()))

(define-method initialize ((self <foo>) initargs)
  (next-method)
  (display "initialize in foo."))

(define-method initialize ((self <bar>) initargs)
  (next-method)
  (display "initialize in bar."))

(d (make <baz> :foo 100 :bar 200))
