split :: String -> String -> [String]
split delim text = split' text "" []
    where
      len = length delim
      split' "" accum results = results ++ [accum]
      split' rest accum results
          | take len rest == delim = split' (drop len rest) "" $ results ++ [accum]
          | otherwise = split' (tail rest) (accum ++ [head rest]) results
