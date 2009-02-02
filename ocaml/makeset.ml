module type OrderedType =
  sig
    type t
    val compare : t -> t -> int
  end

module MakeSet (Order : OrderedType) =
  struct
    type elt = Order.t
    type t = elt list

    let empty = []

    let rec mem elt = function
	[] -> false
      |	x::rest ->
	  let r =Order.compare elt x in
	  (r = 0) || ((r > 0) && mem elt rest)

    let rec add elt = function
	[] -> [elt]
      |	(x::rest as s) ->
	  match Order.compare elt x with
	    0 -> s
	  | r when r < 0 -> elt :: s
	  | _ -> x :: (add elt rest)

    let rec inter s1 s2 =
      match (s1, s2) with
	(s1, []) -> []
      |	([], s2) -> []
      |	((e1::rest1 as s1), (e2::rest2 as s2)) ->
	  match Order.compare e1 e2 with
	    0 -> e1 :: inter rest1 rest2
	  | r when r < 0 -> inter rest1 s2
	  | _ -> inter s1 rest2

    let rec elements s = s
  end

