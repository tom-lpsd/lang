tabStop = 20

main = do cs <- getContents
          putStr $ expand cs
              where
                expand cs = concatMap expandTab cs
                expandTab '\t' = replicate tabStop ' '
                expandTab c = [c]
