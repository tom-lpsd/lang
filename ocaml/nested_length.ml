let rec nested_length = function
    [] -> 0
  | []::res -> nested_length res
  | (_::res1)::res2 -> 1 + (nested_length (res1::res2));;

nested_length [[1;2;3]; [4;5]; [6]; [7;8;9;10]]
