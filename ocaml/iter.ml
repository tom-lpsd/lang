let rec iter f = function
    [] -> ()
  | a :: rest -> begin f a; iter f rest end;

let array_iter f ary =
  let n = ref 0 in
  try 
    while true do
      (f ary.(!n); n := !n + 1; )
    done 
  with
    Invalid_argument _ -> ()

let array_iteri f ary =
  let n = ref 0 in
  try 
    while true do
      (f ary.(!n) !n; n := !n + 1; )
    done 
  with
    Invalid_argument _ -> ()
