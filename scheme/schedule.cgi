(use srfi-1)
(use srfi-19)
(use util.list)
(use text.html-lite)
(use gauche.collection)

(define (make-month m y)
  (make-date 0 0 0 0 1 m y (date-zone-offset (current-date))))

(define (first-day-of-month date)
  (make-month (date-month date) (date-year date)))

(define (next-month date)
  (if (= (date-month date) 12)
      (make-month 1 (+ (date-year date) 1))
      (make-month (+ (date-month date) 1) (date-year date))))

(define (prev-month date)
  (if (= (date-month date) 1)
      (make-month 12 (- (date-year date) 1))
      (make-month (- (date-month date) 1) (date-year date))))

(define (days-of-month date)
  (round->exact
   (- (date->modified-julian-day (next-month date))
      (date->modified-julian-day (first-day-of-month date)))))

(define (date-slices-of-month date)
  (slices (append (make-list (date-week-day (first-day-of-month date)) #f)
		  (iota (days-of-month date) 1))
	  7 #t #f))

(define (month->link date content)
  (html:a :href #`"?y=,(date-year date)&m=,(date-month date)" content))

(define (date-cell year month date)
  (if date
      (html:a :href #`"?y=,|year|&m=,|month|&d=,|date|" date)
      ""))

(define (calender date)
  (html:table
   (html:tr (html:td (month->link (prev-month date) "←"))
	    (html:td :colspan 5 :align "center"
		     #`",(date-year date)/,(date-month date)")
	    (html:td (month->link (next-month date) "→")))
   (html:tr (map html:td "日月火水木金土"))
   (map (lambda (w)
	  (html:tr
	   (map (lambda (d)
		  (html:td (date-cell (date-year date) (date-month date) d)))
		w)))
	(date-slices-of-month date))))

