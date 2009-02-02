split :: Char -> String -> [String]
split delim [] = []
split delim (c:cs)
    | c == delim = "" : rest
    | otherwise = (c : head rest) : tail rest
    where
      rest = split delim cs

main = do text <- getContents
          mapM_ putStr $ split '[' text
