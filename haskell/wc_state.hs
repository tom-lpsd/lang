import Control.Monad.State

data WcState = InWord | InWhite deriving Show

isWhite :: Char -> Bool
isWhite c = c == ' ' || c == '\t' || c == '\n'

wc :: String -> Int
wc str = let (vals, st) = runState (mapM wc' str) InWord;
             final = case st of InWord -> 1; InWhite -> 0
         in foldl (+) final vals
    where
      wc' c 
       | isWhite c = do s <- get
                        case s of 
                          InWord -> do {put InWhite; return 1}
                          InWhite -> return 0
       | otherwise = do s <- get
                        case s of 
                          InWord -> return 0
                          InWhite -> do {put InWord; return 0}

main :: IO ()
main = do str <- getContents
          putStrLn $ show $ wc str
