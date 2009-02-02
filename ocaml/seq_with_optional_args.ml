let rec seq from ?step:(s=1) n =
  if n <= 0 then [] else from :: seq (from + s) ~step:s (n-1)

let rec seq2 from ?step n =
  match step with
    None -> if n <= 0 then [] else from :: seq2 (from + 1) (n - 1)
  | Some s ->
      if n <= 0 then [] else from :: seq2 (from + s) ~step:s (n - 1)
