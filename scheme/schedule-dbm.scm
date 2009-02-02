(use dbm.fsdbm)
(use gauche.parameter)
(use util.match)

(define *db-name* "/Users/tom/.schedule")

(define db (make-parameter #f))

(define-syntax with-db
  (syntax-rules ()
    ((with-db (db path) . body)
     (parameterize
	 ((db (dbm-open <fsdbm>
			:path path
			:rw-mode :write)))
       (guard (e (else (dbm-close (db)) (raise e)))
	 (begin0
	   (begin . body)
	   (dbm-close (db))))))))

(define (initialize)
  (with-db (db *db-name*)
	   (dbm-for-each (db)
			 (lambda (day plan)
			   (dbm-delete! (db) day)))))

(define (schedule . args)
  (with-db (db *db-name*)
	   (match args
	     [() (list-schedule)]
	     [(day) (show-schedule day)]
	     [(day plan) (edit-schedule day plan)]
	     [_ (display ">>>error<<<")])))

(define (schedule-print day plan)
  (print #`",|day|: ,|plan|"))

(define (list-schedule)
    (dbm-for-each (db) schedule-print))


(define (show-schedule day)
  (let* ((plan (dbm-get (db) day #f)))
    (if plan
	(schedule-print day plan)
	(print ">>>empty<<<"))))

(define (edit-schedule day plan)
  (if (eq? plan 'delete)
      (dbm-delete! (db) day)
      (dbm-put! (db) day plan)))
