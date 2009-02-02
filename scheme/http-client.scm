#!/usr/bin/env gosh
(use rfc.http)

(http-get "tom-lpsd.dyndns.org" "/"
	  :sink (open-output-string)
	  :flusher (lambda (sink headers)
		     (print (get-output-string sink))))
