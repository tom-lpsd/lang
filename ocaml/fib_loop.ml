let fibw n = 
  let p = ref 1 and
      c = ref 1 and
      m = ref (n - 1) in 
  while !m > 1 do
    let tmp = !c in
    c := !p + !c;
    p := tmp;
    m := !m - 1
  done;
  !c

let fibf n =
  let p = ref 1 and
      c = ref 1 in
  for x = 3 to n do
    let tmp = !c in
    c := !p + !c;
    p := tmp;
  done;
  !c
