type state = Pressed | NotPressed

type spec = int list

type board = {
    width : int; height : int;
    h_spec : spec list; v_spec : spec list;
    body : state ref list list;
  } 

val is_solved : h_spec:spec list -> v_spec:spec list -> state ref list list -> bool

val board_of_spec : h_spec:spec list -> v_spec:spec list -> board
