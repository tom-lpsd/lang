let rec mem a = function
    [] -> false
  | (h::t) -> if a = h then true else mem a t

let rec intersect s = function
    [] -> []
  | (h::t) -> 
      if mem h s then 
	h :: intersect s t
      else intersect s t

let rec union s = function
    [] -> s
  | (h::t) -> 
      let res = union s t 
      in if mem h res then res else h :: res

let rec diff s = 
    let rec filter f = function
	[] -> []
      | (h::t) -> if f h then h::(filter f t) else filter f t in 
    function
	[] -> s
      | (lh::lt) -> 
	  if mem lh s then 
	    diff (filter ((<>) lh) s) lt
	  else
	    lh :: diff s lt
