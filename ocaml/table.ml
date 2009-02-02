module Table =
  struct
    type ('a, 'b) t = Empty | Entry of 'a * 'b * ('a, 'b) t

    let empty = Empty

    let add key datum table = Entry (key, datum, table)

    let rec retrieve key = function
	Empty -> None
      |	Entry (key', datum, rest) ->
	  if key = key' then Some datum else retrieve key rest

    let rec delete key = function
	Empty -> Empty
      |	Entry (key', datum, rest) ->
	  if key = key' then delete key rest
	  else Entry (key', datum, delete key rest)

    let rec dump = function
	Empty -> []
      |	Entry (key, contents, rest) -> 
	  (key, contents) :: (dump (delete key rest))
  end

module type TABLE1 =
  sig
    type ('a, 'b) t = Empty | Entry of 'a * 'b * ('a, 'b) t
    val empty : ('a, 'b) t
    val add : 'a -> 'b -> ('a, 'b) t -> ('a, 'b) t
    val retrieve : 'a -> ('a, 'b) t -> 'b option
    val dump : ('a, 'b) t -> ('a * 'b) list
  end

module type TABLE2 =
  sig
    type ('a, 'b) t
    val empty : ('a, 'b) t
    val add : 'a -> 'b -> ('a, 'b) t -> ('a, 'b) t
    val retrieve : 'a -> ('a, 'b) t -> 'b option
    val dump : ('a, 'b) t -> ('a * 'b) list
  end

module BtTable : TABLE2 =
  struct
    type ('a, 'b) t = BLf | BNd of ('a * 'b) * ('a, 'b) t * ('a, 'b) t
    let empty = BLf
    let rec add k v = function
      |	BLf -> BNd ((k, v), BLf, BLf)
      |	BNd ((k', v') as top, left, right) ->
	  if k = k' then BNd ((k, v), left, right)
	  else if k < k' then BNd (top, (add k v left), right)
	  else BNd (top, left, (add k v right))
    let rec retrieve k = function
      |	BLf -> None
      |	BNd ((k', v'), left, right) -> 
	  if k = k' then Some v'
	  else if k < k' then retrieve k left
	  else retrieve k right
    let rec dump = function
      |	BLf -> []
      |	BNd (kv, left, right) -> (kv :: (dump left)) @ (dump right)
  end

let ( <<< ) table (key, content) = BtTable.add key content table

let table = BtTable.empty 
    <<< ("a", "the first letter of the English alphabet")
    <<< ("b", "the second letter of the English alphabet")
    <<< ("z", "sleeping noise")

