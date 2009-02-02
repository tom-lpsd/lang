exception Zero_found

let prod_list lst = 
  let rec prod_list' acc = function
      [] -> acc
    | 0 :: rest -> raise Zero_found
    | x :: rest -> prod_list' (x * acc) rest
  in try prod_list' 1 lst with Zero_found -> 0
