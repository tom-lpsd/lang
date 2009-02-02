split :: Char -> String -> [String]
split delim text = split' text []
    where
      split' "" results = reverse results
      split' rest results = 
            let (before, after) = break (== delim) $ tail rest in
            split' after ((delim:before):results)

main = do text <- getContents
          mapM_ putStr $ split '[' text
