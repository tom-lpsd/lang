import List
import System

mytail fileName = do content <- readFile fileName
                     let rows = lines content
                         len  = length rows
                     mapM_ putStrLn $ (tails rows) !! (len - 5)

main = do args <- getArgs
          mapM_ mytail args

