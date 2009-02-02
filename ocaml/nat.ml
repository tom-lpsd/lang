type nat = Zero | Succ of nat

let rec add m n =
  match m with Zero -> n | Succ m' -> Succ (add m' n)

let rec mul m n =
  match m with Zero -> Zero | Succ m' -> add n (mul m' n)

let rec monus m n =
  match n with 
    Zero -> m
  | Succ n' -> 
      match m with
	Zero -> Zero
      |	Succ m' -> monus m' n'

let rec minus m n =
  match n with 
    Zero -> Some m
  | Succ n' -> 
      match m with
	Zero -> None
      |	Succ m' -> minus m' n'
