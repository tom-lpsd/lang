(use dbi)
(use gauche.parameter)
(use gauche.collection)
(use util.match)

(define *db-name* "dbi:mysql:user=tom;db=schedule")

(define db (make-parameter #f))

(define-syntax with-db
  (syntax-rules ()
    ((with-db (db dsn) . body)
     (parameterize
	 ((db (dbi-connect dsn)))
       (guard (e (else (dbi-close (db)) (raise e)))
	 (begin0
	   (begin . body)
	   (dbi-close (db))))))))

(define (initialize)
  (with-db (db *db-name*)
    (dbi-do (db)
	    "DROP TABLE IF EXISTS plans")
    (dbi-do (db)
	    "CREATE TABLE plans (day DATE, plan VARCHAR(255), PRIMARY KEY (day))")))

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
  (let* ((result (dbi-do (db)
			 "SELECT day, plan FROM plans"))
	 (getter (relation-accessor result))
	 (plan-list (map
		     (lambda (row)
		       (cons (getter row "day")
			     (getter row "plan")))
		     result)))
    (for-each
     (lambda (p)
       (schedule-print (car p) (cdr p)))
     plan-list)))

(define (schedule-get key)
  (let* ((query (dbi-prepare (db)
			     "SELECT day, plan FROM plans WHERE day = ?"))
	 (result (dbi-execute query key))
	 (getter (relation-accessor result))
	 (plan-list (map
		     (lambda (row)
		       (cons (getter row "day")
			     (getter row "plan")))
		     result)))
    plan-list))

(define (show-schedule key)
  (let ((plan-list (schedule-get key)))
    (if (pair? plan-list)
	(let ((key (caar plan-list))
	      (plan (cdar plan-list)))
	  (schedule-print key plan))
	(print ">>>empty<<<"))))

(define (edit-schedule key plan)
  (let ((plan-list (schedule-get key)))
    (cond [(null? plan-list)
	   (let ((query (dbi-prepare (db)
		  "INSERT INTO plans (day, plan) VALUES (?, ?)")))
	     (dbi-execute query key plan))]
	  [(eq? plan 'delete)
	   (let ((query (dbi-prepare (db)
		  "DELETE FROM plans WHERE day = ?")))
	     (dbi-execute query key))]
	  [else
	   (let ((query (dbi-prepare (db)
			 "UPDATE plans SET plan = ? WHERE day = ?")))
	     (dbi-execute query plan key))])))


