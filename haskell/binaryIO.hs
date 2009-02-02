
split body bound = split' body "" []
    where
      len = length bound
      split' [] pre results = results ++ [pre]
      split' body pre results = if (take len body) == bound
                                      then split' (drop len body) "" (results ++ [pre])
                                      else split' (tail body) (pre ++ [(head body)]) results
