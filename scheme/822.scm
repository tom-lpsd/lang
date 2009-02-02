(use rfc.822)
(use gauche.interactive)

(define headers (string-join '("Host: tom-lpsd.dyndns.org"
			       "Content-Type: text/plain"
			       "Accept-Language: jp") "\r\n"))

(call-with-input-string headers
  (lambda (in)
    (d (rfc822-read-headers in))))
