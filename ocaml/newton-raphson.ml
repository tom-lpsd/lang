open Num

let deriv f x =
  let dx = Int 1 // Int 1000000000 in
  (f(x +/ dx) -/ f(x)) // dx

let fixpoint f init =
  let threshold = Int 1 // Int 1000000000 in
  let rec loop x =
    let next = f x in
    if abs_num (x -/ next) </ threshold then x
    else loop next
  in loop init

let newton_transform f = fun x -> x -/ f(x) // (deriv f x)

let newton_method f guess = fixpoint (newton_transform f) guess

(*
let square_root a = newton_method (fun x -> x *. x -. a) 1.0;;
square_root 5.0;;
*)


