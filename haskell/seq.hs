import System.Random
import Control.Parallel

quicksort' :: [Int] -> [Int]
quicksort' []      = []
quicksort' [x]     = [x]
quicksort' (x:xs)  = (forceList losort) `par`
                     (forceList hisort) `par`
                     losort ++ (x:hisort)
                     where
                       losort = quicksort' [y|y <- xs, y < x] 
                       hisort = quicksort' [y|y <- xs, y >= x]

forceList :: [a] -> ()
forceList [] = ()
forceList (x:xs) = x `pseq` forceList xs

main = do g <- getStdGen
          print $ quicksort' $ take 100000 (randoms g)
