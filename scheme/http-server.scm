;; -*- coding: utf-8 -*-

(use gauche.net)
(use util.match)
(use rfc.822)
(use rfc.uri)
(use text.tree)
(use text.html-lite)
(use www.cgi)
(use util.list)
(use srfi-27)

(define (run-server)
  (let1 server-sock (make-server-socket 'inet 8080 :reuse-addr? #t)
    (guard (e [else (socket-close server-sock) (raise e)])
      (let loop ((client (socket-accept server-sock)))
	(guard (e [else (socket-close client) (raise e)])
	  (handle-request (get-request (socket-input-port client))
			  (socket-output-port client))
	  (socket-close client))
	(loop (socket-accept server-sock))))))

(define (get-request iport)
  (rxmatch-case (read-line iport)
    [test eof-object? 'bad-request]
    [#/^(GET|HEAD)\s+(\S+)\s+HTTP\/\d+\.\d+$/ (_ meth abs-path)
     (list* meth abs-path (rfc822-header->list iport))]
    [#/^[A-Z]+/ () 'not-implemented]
    [else 'bad-request]))

(define (handle-request request oport)
  (match request
    ['bad-request (display "HTTP/1.1 400 Bad Request\r\n\r\n" oport)]
    ['not-implemented (display "HTTP/1.1 501 Not Implemented\r\n\r\n" oport)]
    [(meth abs-path . headers)
     (receive (auth path q frag) (uri-decompose-hierarchical abs-path)
       (let1 content
	   (render-content path (cgi-parse-parameters :query-string (or q "")))
	 (display "HTTP/1.1 200 OK\r\n" oport)
	 (display "Content-Type: text/html; charset=utf-8\r\n" oport)
	 (display #`"Content-Length: ,(string-size content)\r\n" oport)
	 (display "\r\n" oport)
	 (when (equal? meth "GET") (display content oport))))]))

(define *dungeon*
  '(["あなたは森の北端にいる。道は南に続いている"
     (s . 1)]
    ["あなたは鬱蒼として森の中の道にいる。\n道は南北に伸びている。東に降りてゆく小径がある。"
     (n . 0)
     (s . 2)
     (e . 3)]
    ["足下がぬかるんでいる。道は直角に折れ，北と西に伸びている。西に続く道の先が明るくなっている。"
     (n . 1)
     (w . 4)]
    ["あなたは沼のほとりにいる。空気の動きが止まり，暑さを感じる。西に上ってゆく小径がある。"
     (w . 1)]
    ["突然目の前が開けた。あなたは森の中の広場にいる。丈の短い，柔らかそうな草が一面に広場を覆っている。道が東に伸びている。"
     (e . 2)]))


(random-source-randomize! default-random-source)

(define *conts* (make-hash-table 'eqv?))

(define *max-id* (expt 2 64))

(define (push-cont! cont)
  (let1 cid (random-integer *max-id*)
    (cond [(hash-table-get *conts* cid #f) (push-cont! cont)]
	  [else (hash-table-put! *conts* cid cont) cid])))

(define (a/cont cont . args)
  (let1 cid (push-cont! cont)
    (apply html:a :href #`"?c=,cid" args)))

(define (get-cont params)
  (hash-table-get *conts*
		  (cgi-get-parameter "c" params :convert string->number)
		  #f))
  
(define (get-direction dir)
  (assoc-ref '((n . "北") (e . "東") (w . "西") (s . "南")) dir))

(define (render-content path params)
  (cond [(get-cont params) => (cut <> params)]
	[else (run-application params)]))

(define (run-application params)
  (let loop ((location (list-ref *dungeon* 0))
	     (history '()))
    (define (render-selector selector)
      (html:li (a/cont (lambda (params)
			 (loop (list-ref *dungeon* (cdr selector))
			       (cons location history)))
		       (get-direction (car selector)) "へ進む")))
    (tree->string
     (html:html
      (html:head (html:title "simple httpd"))
      (html:body (html:p (html-escape-string (car location)))
		 (html:ul (map render-selector (cdr location)))
		 (html:hr)
		 (map (lambda (p) (html:p (html-escape-string (car p))))
		      history))))))
  
(define (main args)
  (run-server)
  0)

	       