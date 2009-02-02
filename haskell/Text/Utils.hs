module Text.Utils (split) where

split :: Char -> String -> [String]
split c "" = []
split c (s:str) 
    | c == s = "":(split c str)
    | otherwise = case (split c str) of
                    [] -> [s:[]]
                    h:t -> (s:h):t

