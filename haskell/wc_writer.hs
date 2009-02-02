import Control.Monad.Writer

data WcState = InWord | InWhite deriving Show

isWhite :: Char -> Bool
isWhite c = c == ' ' || c == '\t' || c == '\n'

wc :: String -> Int
wc str = getSum.snd.runWriter $ foldM wc' InWord str
    where
      wc' InWhite  c
       | isWhite c = return InWhite
       | otherwise = return InWord
      wc' InWord c 
       | isWhite c = Writer (InWhite, Sum 1) 
       | otherwise = return InWord

main :: IO ()
main = do str <- getContents
          putStrLn $ show $ wc str
