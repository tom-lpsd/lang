open OUnit

let rec sum_list = function
    [] -> 0
  | n :: rest -> n + (sum_list rest)

let sum_test _ =
  assert_equal (sum_list [1;2;3;4;5;6;7;8;9;10]) 55

let suite = "list sum " >::: 
  ["sum_test" >:: sum_test]

let _ =  run_test_tt_main suite
