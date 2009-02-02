type 'a seq = Cons of 'a * (unit -> 'a seq)

let rec from n = Cons (n, fun () -> from (n + 1))

let rec mapseq f (Cons (x, tail)) =
  Cons (f x, fun () -> mapseq f (tail ()))

let rec take n (Cons (x, tail)) =
  if n < 1 then [] else (x :: take (n - 1) (tail ()))

type 'a someseq = Cons of 'a * ('a -> 'a someseq)

let rec mapsseq f (Cons (x, tail)) = 
  Cons (f x, fun x' -> mapsseq f (tail x))
