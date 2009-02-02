let map2 f lst = 
  let rec map2' acc = function
      [] -> List.rev acc
    | (h::t) -> map2' (f h::acc) t
  in map2' [] lst;;

map2 ((+) 1) [1;2;3;4]
