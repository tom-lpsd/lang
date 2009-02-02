import Char

bytesCount [] = 0
bytesCount (c:cs) = 1 + bytesCount cs

linesCount str = nullLines str
    where nullLines [] = 0
          nullLines ('\n':cs) = nullLines cs
          nullLines (c:cs) = trueLines cs
          trueLines [] = 0
          trueLines ('\n':cs) = 1 + nullLines cs
          trueLines (c:cs) = trueLines cs

wordsCount2 str = outWords str
    where wordScan f [] = 0
          wordScan f (c:cs)
              | isAlphaNum c = f (inWords cs)
              | otherwise    = outWords cs
          outWords str = wordScan (\n -> 1 + n) str
          inWords str = wordScan id str

wordsCount str = outWords str
    where outWords [] = 0
          outWords ('\'':cs) = 1 + inQuote cs
          outWords (c:cs)
              | isAlphaNum c = 1 + inWords cs
              | otherwise    = outWords cs
          inWords [] = 0
          inWords (c:cs)
              | isAlphaNum c = inWords cs
              | otherwise    = outWords cs
          inQuote [] = 0
          inQuote ('\'':cs) = outWords cs
          inQuote (c:cs) = inQuote cs

main :: IO ()
main = do str <- getContents
          putStrLn $ show $ wordsCount str
