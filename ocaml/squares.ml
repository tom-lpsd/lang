let squares r =
  let sup = int_of_float (sqrt (float_of_int r)) in
  let rec squares' x y acc = 
    if y > x then squares' (x + 1) 1 acc
    else if x > sup then acc
    else if (x * x + y * y) = r then 
      squares' x (y + 1) ((x, y)::acc)
    else
      squares' x (y + 1) acc in
  squares' 1 1 [];;

squares 48612265 (* there is 32 answers. *)
