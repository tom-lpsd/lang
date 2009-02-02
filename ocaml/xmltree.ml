type ('a, 'b) xml = XLf of 'b option | XBr of 'a * ('a, 'b) xml list
type token = PCDATA of string | Open of string | Close of string

let rec xml_of_tokens = 
  let rec xml_of_tokens' e stk = function
      [] -> (XLf None, [])
    | Open e'::rest -> 
	let (result, remain) = xml_of_tokens' e' [] rest 
	in xml_of_tokens' e (result :: stk) remain
    | PCDATA str::rest -> xml_of_tokens' e (XLf (Some str)::stk) rest
    | Close e'::rest -> 
	if e = e' then 
	  (XBr (e, List.rev stk), rest)
	else
	  (XLf None, [])
  in function
      [] -> XLf None
    | Open e::rest ->  
	let (result, remain) = xml_of_tokens' e [] rest
	in if remain = [] then result else XLf None
    | _ -> XLf None

let sample = [Open "a"; Open "b"; Close "b";
	      Open "c"; PCDATA "Hello"; Close "c"; Close "a"]

let sample2 = [Open "a"; Open "b"; PCDATA "World"; Open "e"; Close "e"; Close "b";
	      Open "c"; PCDATA "Hello"; Close "c"; Close "a"]
