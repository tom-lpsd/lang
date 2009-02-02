let rec roman alist n = 
  let rec roman' alist n acc =
    match alist with
      [] -> acc
    | (d, c)::t -> 
	if d <= n then 
	  roman' alist (n - d) (acc ^ c)
	else
	  roman' t n acc
  in roman' alist n "";;

roman [(1000, "M"); (500, "D"); (100, "C"); (50, "L"); 
       (10, "X"); (5, "V"); (1, "I")] 1984;;

roman [(1000, "M"); (900, "CM"); (500, "D"); (400, "CD");
       (100, "C"); (90, "XC"); (50, "L"); (40, "XL");
       (10, "X"); (9, "IX"); (5, "V"); (4, "IV"); (1, "I")] 1984
