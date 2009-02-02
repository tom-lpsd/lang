split :: Char -> String -> [String]
split delim s
  | [] <- rest = [token]
  | otherwise = token : split delim (tail rest)
  where (token,rest) = span (/=delim) s

main = do text <- getContents
          mapM_ putStr $ split '[' text
