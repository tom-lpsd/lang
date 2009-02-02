(defmacro if-by-cond (test then else)
  `(cond (,test ,then)
	 (t ,else)))

