split :: Char -> String -> [String]
split c str = split' str [""]
    where
      split' [] acc = reverse $ map reverse acc
      split' (s:str) acc@(ah:at)
          | c == s = split' str ("":acc)
          | otherwise = split' str $ (s:ah):at

main = do text <- getContents
          mapM_ putStr $ split '[' text
