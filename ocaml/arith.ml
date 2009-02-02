type arith = 
    Const of int | Add of arith * arith | Mul of arith * arith

let rec eval = function
    Const n -> n
  | Mul (x, y) -> (eval x) * (eval y)
  | Add (x, y) -> (eval x) + (eval y)

let rec string_of_arith = function
    Const n -> string_of_int n
  | Mul (x, y) -> "(" ^ string_of_arith x ^ "*" ^ string_of_arith y ^ ")"
  | Add (x, y) -> "(" ^ string_of_arith x ^ "+" ^ string_of_arith y ^ ")"

let rec expand = function
  | Mul (Add (x, y), z) -> Add ((expand (Mul (expand x, expand z))),
				(expand (Mul (expand y, expand z))))
  | Mul (x, Add (y, z)) -> Add ((expand (Mul (expand x, expand y)),
				 expand (Mul (expand x, expand z))))
  | Add (x, y) -> Add (expand x, expand y)
  | x -> x

let exp = Mul (Add (Const 3, Const 4), 
	       Add (Const 2, Const 5))

let exp2 = Mul (Mul (Const 2, Const 2), 
		Mul (Const 2, Const 2))

let exp3 = Add (Mul (Const 1, 
		     Add (Const 6, 
			  Mul (Const 2, 
			       Add (Const 3, Const 4)))), 
		Const 5)
