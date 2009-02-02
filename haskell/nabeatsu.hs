import Data.List

mul_of_3 = cycle [False, False, True]

mul_of_8 = cycle [False, False, False, False, False, False, False, True]

{-
include_3 = iter ([False, False, True] ++ (replicate 7 False)) 1
    where
      expand = concatMap (replicate 10)
      iter bs n = let rest = drop n $ iter (expand bs) (n*10)
                  in bs ++ (zipWith (||) (cycle bs) rest)
-}

include_3 = tail $ iter ([False, False, False, True] ++ (replicate 6 False)) 10
    where
      expand = concatMap (replicate 10)
      iter bs n = let rest = drop n $ iter (expand bs) (n*10)
                  in bs ++ zipWith (||) (cycle bs) rest

merge x y z n = show n ++ 
                (if x || y then "~~~" else "") ++
                (if z then "ooOOo" else "")

nabeatsu = zipWith4 merge include_3 mul_of_3 mul_of_8 [1..]

main = mapM_ putStrLn $ take 400 nabeatsu
