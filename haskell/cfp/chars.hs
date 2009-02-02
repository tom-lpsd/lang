import Data.Char

charToNum :: Char -> Int
charToNum c 
    | isDigit c = ord c - ord '0'
    | otherwise = 0

