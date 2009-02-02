let rec find1 x = function
    [] -> 0
  | a :: l when a = x -> 1
  | _ :: l -> 1 + find x l

let rec find2 x = function
    [] -> None
  | a :: l when a = x -> Some 1
  | _ :: l -> match find2 x l with None -> None | Some i -> Some (i + 1)

let rec find3 x = function
    [] -> raise Not_found
  | a :: l when a = x -> 1
  | _ :: l -> 1 + find3 x l

let rec find4 x l = 
  let find4' = function
      [] -> raise Not_found
    | a :: l when a = x -> 1
    | _ :: l -> 1 + find3 x l
  in try Some (find4' l) with Not_found -> None

let rec nth n l =
  match (n, l) with
    (n, _) when n <= 0 -> None
  | (1, a::_) -> Some a
  | (_, _::rest) -> nth (n - 1) rest
  | (_, []) -> None
