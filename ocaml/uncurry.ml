open OUnit

let curry f x y = f (x, y)
let uncurry f (x, y) = f x y
let average (x, y) = (x +. y) /. 2.0

let curried_avg = curry average
let uncurried_avg = uncurry curried_avg

let test_average _ =
  assert_equal (average (4.0, 5.3)) 4.65

let test_curried _ =
  assert_equal (curried_avg 4.0 5.3) 4.65

let test_uncurried _ =
  assert_equal (uncurried_avg (4.0, 5.3)) 4.65

let suite = "uncurry" >::: ["test_average" >:: test_average;
			    "test_curried" >:: test_curried;
			    "test_uncurried" >:: test_uncurried]

let _ =
  let verbose = ref false in
  let set_verbose _ = verbose := true in
  Arg.parse
    [("-verbose", Arg.Unit set_verbose, "Run the test in verbose mode.");]
    (fun x -> raise (Arg.Bad ("Bad argument : " ^ x)))
    ("usage: " ^ Sys.argv.(0) ^ " [-verbose]");
  run_test_tt ~verbose:!verbose suite
