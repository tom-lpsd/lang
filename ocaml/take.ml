let rec take n lst = 
  if n <= 0 then []
  else 
    match lst with
      [] -> []
    | (h::t) -> h :: take (n - 1) t;;

take 3 [1;2;3;4;5]
