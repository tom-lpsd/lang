let max_list (h::t) =
  let rec max_list' max = function
      [] -> max
    | (v::res) ->max_list' (if v > max then v else max) res
  in max_list' h t;;

max_list [7; 9; 0; -5]
