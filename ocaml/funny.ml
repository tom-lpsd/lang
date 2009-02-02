let id x = x
let ($) f g x = f (g x)

let rec funny f n = 
  if n = 0 then id
  else if n mod 2 = 0 then funny (f $ f) (n / 2)
  else funny (f $ f) (n / 2) $ f

let double x = x * x

let _ =
  let dd = funny double 2 in print_int (dd 2);
  print_string "\n";
  let ddd = funny double 3 in print_int (ddd 2);
  print_string "\n"
