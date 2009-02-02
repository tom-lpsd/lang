import IO
import Char

reveal :: IO ()
reveal = do c <- getChar
            if c == 'q'
               then return ()
               else do putStrLn $ show (ord c)
                       reveal 
