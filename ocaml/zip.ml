let rec zip l = function
    [] -> []
  | (rh::rt) -> 
      match l with
	[] -> []
      | (lh::lt) -> (lh, rh) :: zip lt rt;;

zip [2;3;4;5;6;7;8;9;10;11] [true; true; false; true; 
			     false; true; false; false; false; true]
