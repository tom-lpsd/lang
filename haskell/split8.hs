split :: Char -> String -> [String]
split c str = split' str []
    where
      split' str acc =
          case break (==c) str of
            (h, "") -> reverse $ h:acc
            (h, t:ts) -> split' ts (h:acc)

main = do text <- getContents
          mapM_ putStr $ split '[' text
