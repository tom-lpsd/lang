let rec drop n lst =
  if n <= 0 then lst
  else
    match lst with
      [] -> []
    | (_::t) -> drop (n - 1) t;;

drop 3 [1;2;3;4;5;6;7];;
drop 10 [1;2;3;4];;
drop ~-1 [1;2;3]
