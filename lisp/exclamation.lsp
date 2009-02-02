(set-macro-character #\!
		     #'(lambda (stream char)
			 (list 'apply '#'+ (read stream t nil t))))
