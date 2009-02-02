type 'a tree = Lf | Br of 'a * 'a tree * 'a tree

let rec size = function
    Lf -> 0
  | Br (_, left, right) -> 1 + size left + size right

let rec comptree x = function
    0 -> Lf
  | n -> let childs = comptree x (n - 1) in Br (x, childs, childs)

let comptree' n =
  let rec comptree'' x h =
    if h < 1 then Lf
    else Br (x, comptree'' (x * 2) (h - 1), comptree'' (x * 2 + 1) (h - 1))
  in comptree'' 1 n

let rec preord t l = 
  match t with
    Lf -> l
  | Br (x, left, right) -> x :: (preord left (preord right l))

let rec inord t l =
  match t with
    Lf -> l
  | Br (x, left, right) -> inord left (x :: inord right l)

let rec postord t l =
  match t with
    Lf -> l
  | Br (x, left, right) -> postord left (postord right (x :: l))

let rec reflect = function
    Lf -> Lf
  | Br (x, left, right) -> Br (x, reflect right, reflect left)

type 'a rosetree = RLf | RBr of 'a * 'a rosetree list


let rec tree_of_rtree = function
    RLf -> Br (None, Lf, Lf)
  | RBr (a, rtrees) -> Br (Some a, tree_of_rtreelist rtrees, Lf)
and tree_of_rtreelist = function
    [] -> Lf
  | rtree :: rest -> 
      let Br (a, left, Lf) = tree_of_rtree rtree
      in Br (a, left, tree_of_rtreelist rest)

let rec rtree_of_tree = function
    Lf -> RLf
  | Br (Some a, left, Lf) -> RBr (a, rtreelist_of_tree left)
and rtreelist_of_tree = function
    Lf -> []
  | Br (None, _, right) -> RLf :: rtreelist_of_tree right
  | Br (Some a, left, right) -> RBr (a, rtreelist_of_tree left) :: rtreelist_of_tree right;;

let rtree = RBr ("a",
	     [RBr ("b", [RBr ("c", [RLf]); RLf; RBr ("d", [RLf])]); RBr ("e", [RLf]);
	      RBr ("f", [RLf])]);;

rtree_of_tree (tree_of_rtree rtree);;
