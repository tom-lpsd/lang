open OUnit

let rec repeat f n x =
  if n > 0 then repeat f (n - 1) (f x) else x

let fib n =
  let (fibn, _) = 
    if n <= 1 then
      (1, 1)
    else 
      repeat (fun (x, y) -> (x + y, x)) (n - 1) (1, 1)
  in fibn

let fib_test _ = 
  assert_equal (fib 0) 1;
  assert_equal (fib 1) 1;
  assert_equal (fib 10) 89;
  assert_equal (fib 11) 144

let suite = "fib by repeat function" >::: 
  ["fib_test" >:: fib_test]

let _ =
  run_test_tt_main suite
