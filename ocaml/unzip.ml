let rec unzip = function
    [] -> ([], [])
  | (f, s)::res -> let (x, y) = unzip res in (f::x , s::y);;

unzip [(2, true); (3, true); (4, false); (5, true); (6, false)]
