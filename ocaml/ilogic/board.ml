open MySupport

type state = Pressed | NotPressed

type spec = int list

type board = {
    width : int; height : int;
    h_spec : spec list; v_spec : spec list;
    body : state ref list list;
  } 

let rec removeNP cells =
  match cells with
    [] -> []
  | NotPressed::cells -> removeNP cells
  | cells -> cells

let rec removeP n cells =
  match (n, cells) with
    (0, Pressed::_) -> failwith "remove_P"
  | (0, _) -> cells
  | (_, Pressed::cells') -> removeP (n-1) cells'
  | (_, ([] | NotPressed::_)) -> failwith "remove_P"

let rec check_row spec cells =
  match (spec, removeNP cells) with
    ([], []) -> true
  | ([], Pressed::_) -> false
  | (n::spec', cells') ->
      try check_row spec' (removeP n cells') with
	Failure _ -> false

let rec check_rows spec board =
  List.fold_right (&&) (List.map2 check_row spec board) true

let rec  is_empty = function
    [] -> true
  | []::board' -> is_empty board'
  | _ -> false

let rec split_col = function
    [] -> ([], [])
  | (c::row)::rows ->
      let (hds, tls) = split_col rows in c::hds, row::tls
  | _ -> failwith "split_col"

let rec trans_board board =
  if is_empty board then []
  else let (col, board') = split_col board in col::trans_board board'

let is_solved ~h_spec ~v_spec board =
  let board = List.map (fun row -> List.map (!) row) board in
  check_rows h_spec board && check_rows v_spec (trans_board board)

let board_of_spec ~h_spec ~v_spec =
  let width = List.length v_spec
  and height = List.length h_spec in
  { width = width; height = height;
    h_spec = h_spec; v_spec = v_spec;
    body = make_list height (fun () -> make_list width (fun () -> (ref NotPressed))) }
    
