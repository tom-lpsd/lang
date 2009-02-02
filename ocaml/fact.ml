let rec fact n = 
  if n <= 1  then 1 else n * fact (n-1);;

let fact' n =
  let rec iter n acc = 
    if n <= 1 then 
      acc 
    else 
      iter (n-1) (acc * n)
  in iter (n-1) n;;

let _ = 
  print_int (fact 10);
  print_string "\n";;
