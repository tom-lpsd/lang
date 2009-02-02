module type QUEUE =
  sig
    type 'a t
    exception Empty
    val empty: 'a t
    val add: 'a t -> 'a -> 'a t
    val take: 'a t -> 'a * 'a t
    val peek: 'a t -> 'a
  end

module Queue1 : QUEUE =
  struct
    type 'a t = 'a list
    exception Empty
    let empty = []
    let add q v = q @ [v]
    let take = function
      |	[] -> raise Empty
      |	x::xs -> (x, xs)
    let peek = function
      |	[] -> raise Empty
      |	x::xs -> x
  end

module Queue2 : QUEUE =
  struct
    type 'a t = ('a list * 'a list)
    exception Empty
    let empty = ([], [])
    let add (b, a) v = 
      match b with
      |	[] -> (v::b, a)
      |	_ -> (b, v::a)
    let rec reconstruct (b, a) =
      match b with
      |	[] -> 
	  (match a with
	  | [] -> ([], [])
	  | _ -> 
	      let rec reconstruct' (b', a') =
		match a' with
		| [] -> (b', [])
		| h::t -> reconstruct' (h::b', t)
	      in reconstruct' (b, a))
      | _ -> (b, a)
    let take (b, a) = 
      match b with
      |	[] -> raise Empty
      |	h::t -> (h, reconstruct (t, a))
    let peek (b, a) =
      match b with
      |	[] -> raise Empty
      |	h::t -> h
  end

let q1 = Queue2.empty
let q2 = Queue2.add q1 1
let q3 = Queue2.add q2 4
let q4 = Queue2.add q3 5
let q5 = Queue2.add q4 10
let (v1, r1) = Queue2.take q5
let (v2, r2) = Queue2.take r1
let (v3, r3) = Queue2.take r2
let q6 = Queue2.add r3 20
let (v4, r4) = Queue2.take q6
let (v5, r5) = Queue2.take r4
