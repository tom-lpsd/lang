let rec concat = function
    [] -> []
  | []::res -> concat res
  | (h::t)::res -> h :: concat (t::res);;

concat [[0;3;4]; [2]; []; [5;0]]
