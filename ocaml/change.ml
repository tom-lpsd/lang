let rec change coins amount =
  match (coins, amount) with
    (_, 0) -> []
  | ((c :: rest) as coins, total) ->
      if c > total then change rest total
      else c :: change coins (total - c)

let rec change2 coins amount =
  match (coins, amount) with
    (_, 0) -> []
  | ((c :: rest) as coins, total) ->
      if c > total then change2 rest total
      else
	(try
	  c :: change2 coins (total - c)
	with Failure "change" -> change2 rest total)
  | _ -> raise (Failure "change")

let us_coins = [25; 10; 5; 1]
and gb_coins = [50; 20; 10; 5; 2; 1]
