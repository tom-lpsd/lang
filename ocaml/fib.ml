open OUnit

type intseq = Cons of int * (int -> intseq)

let rec step n x = Cons (x + n, step (n + 1))

let rec nthseq n (Cons (x, f)) = 
  if n < 2 then x
  else nthseq (n - 1) (f x)

let fib = 
  let rec fib' p c = Cons (p+c, fib' c)
  in Cons (1, fib' 0)

let is_prime x = 
  let rec is_divisible_from_2_to n =
    (n > 1) && ((x mod n = 0) || is_divisible_from_2_to (n - 1))
  in not (is_divisible_from_2_to (x - 1))

let is_prime' x = 
  let rec is_divisible_from_2_to n =
    (n > 1) && ((x mod (x - n + 1) = 0) || is_divisible_from_2_to (n - 1))
  in not (is_divisible_from_2_to (x - 1))

let is_prime'' x = 
  let thresh = int_of_float (floor (sqrt (float_of_int x))) in
  let rec is_divisible_from_2_to n =
    (n > thresh) && 
    ((x mod (x - n + 1) = 0) || is_divisible_from_2_to (n - 1))
  in not (is_divisible_from_2_to (x - 1))

let rec is_prime''' x = function
    [] -> true
  | n :: rest -> if (x mod n = 0) then false else is_prime''' x rest

let rec is_prime'''' x = 
  let thresh = int_of_float (floor (sqrt (float_of_int x))) 
  in function
      [] -> true
    | n :: rest -> if (x mod n = 0) || n < thresh then false else is_prime''' x rest

let rec next_prime x =
  if is_prime (x + 1) then x + 1 else next_prime (x + 1)

let rec prime_seq x =
  if is_prime (x + 1) then Cons (x + 1, prime_seq) else prime_seq (x + 1)

let rec prime_seq' x =
  if is_prime' (x + 1) then Cons (x + 1, prime_seq') else prime_seq' (x + 1)

let rec prime_seq'' x =
  if is_prime'' (x + 1) then Cons (x + 1, prime_seq'') else prime_seq'' (x + 1)

let rec prime_seq''' primes x =
  if is_prime''' (x + 1) primes then 
    Cons (x + 1, prime_seq''' (x + 1::primes))
  else prime_seq''' primes (x + 1)

let rec prime_seq'''' primes x =
  if is_prime'''' (x + 1) primes then 
    Cons (x + 1, prime_seq'''' (x + 1::primes))
  else prime_seq'''' primes (x + 1)

let prime_test1 _ = 
  assert_equal (nthseq 3000 (prime_seq 1)) 27449
let prime_test2 _ = 
  assert_equal (nthseq 3000 (prime_seq' 1)) 27449
let prime_test3 _ = 
  assert_equal (nthseq 3000 (prime_seq'' 1)) 27449
let prime_test4 _ = 
  assert_equal (nthseq 3000 (prime_seq''' [] 1)) 27449
let prime_test5 _ = 
  assert_equal (nthseq 3000 (prime_seq'''' [] 1)) 27449

let suite = "prime_test" >::: 
  ["test1" >:: prime_test1;
   "test2" >:: prime_test2;
   "test3" >:: prime_test3;
   "test4" >:: prime_test4;
   "test5" >:: prime_test5]

let _ =
  run_test_tt_main suite
