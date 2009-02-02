(use util.match)
(use srfi-1)

(define *db-name* "/Users/tom/.schedule.dat")

(define (schedule-write schedule-data)
  (receive (out tempfile)
      (sys-mkstemp "schedule")
    (write schedule-data out)
    (close-output-port out)
    (sys-rename tempfile *db-name*)))

(define (initialize)
  (schedule-write '()))

(define (schedule . args)
  (match args
    [() (list-schedule)]
    [(day) (show-schedule day)]
    [(day plan) (edit-schedule day plan)]
    [_ (display ">>>error<<<")]))


(define (schedule-print item)
  (print #`",(car item): ,(cdr item)"))

(define (list-schedule)
  (call-with-input-file *db-name*
    (lambda (in)
      (let ((schedule-data (read in)))
	(for-each schedule-print
		  schedule-data)))))

(define (schedule-find day)
  (call-with-input-file *db-name*
    (lambda (in)
      (let* ((schedule-data (read in))
	     (item (assoc day schedule-data)))
	(values item schedule-data)))))

(define (show-schedule day)
  (receive (item schedule-data)
      (schedule-find day)
    (if item
	(schedule-print item)
	(print ">>>empty<<<"))))

(define (edit-schedule day plan)
  (receive (item schedule-data)
      (schedule-find day)
    (cond [(not item)
	   (push! schedule-data (cons day plan))]
	  [(eq? plan 'delete)
	   (set! schedule-data (delete item schedule-data))]
	  [else
	   (set! (cdr item) plan)])
    (schedule-write schedule-data)))
