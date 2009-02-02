;; -*- coding: utf-8 -*-
(define (last-pair lis)
  (if (pair? (cdr lis))
      (last-pair (cdr lis))
      lis))
