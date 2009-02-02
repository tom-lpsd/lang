split :: Char -> String -> [String]
split c "" = []
split c (s:str) 
    | c == s = "":(split c str)
    | null str = [s:[]]
    | otherwise = let (h:t) = (split c str) in (s:h):t

main = do text <- getContents
          mapM_ putStr $ split '[' text
