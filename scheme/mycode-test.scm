;; -*- coding: utf-8 -*-
;; mycode-test.scm
(use gauche.test)

(define (run-last-test p n)
  (define (loop lis i)
    (unless (>= i n)
	    (test* (format "last-pair ~s" i) p (last-pair lis))
	    (loop (cons i lis) (+ i 1))))
  (loop p 0))

(test-start "mycode.scm")

(load "./mycode")
(test-section "regular list")
(test* "last-pair #1" '(3) (last-pair '(1 2 3)))
(test* "last-pair #2" '(1) (last-pair '(1)))
(test-section "dotted pair")
(test* "last-pair #3" '(2 . 3) (last-pair '(1 2 . 3)))
(run-last-test '(a) 5)
(run-last-test '(a . b) 5)

(test-end)
