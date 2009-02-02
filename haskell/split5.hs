split :: Char -> String -> [String]
split c "" = []
split c (s:str) 
    | c == s = "":(split c str)
    | otherwise = case (split c str) of
                    [] -> [s:[]]
                    h:t -> (s:h):t

main = do text <- getContents
          mapM_ putStr $ split '[' text
