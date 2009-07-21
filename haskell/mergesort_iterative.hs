import Data.List

merge :: (Ord a) => [a] -> [a] -> [a]
merge xs ys = merge' xs ys []
    where
      merge' [] [] zs = reverse zs
      merge' [] (y:ys) zs = merge' [] ys (y:zs)
      merge' (x:xs) [] zs = merge' xs [] (x:zs)
      merge' xs@(xh:xt) ys@(yh:yt) zs
          | xh <= yh  = merge' xt ys (xh:zs)
          | otherwise = merge' xs yt (yh:zs)

mergeSuccPairs :: (Ord a) => [[a]] -> [[a]] -> [[a]]
mergeSuccPairs (x:[]) ys = x:ys
mergeSuccPairs (x1:x2:[]) ys = (merge x1 x2):ys
mergeSuccPairs (x1:x2:xs) ys = mergeSuccPairs xs $ merge x1 x2:ys

mergesort :: (Ord a) => [a] -> [a]
mergesort xs = mergesort' (groupBy (const . const False) xs)
    where
      mergesort' xs =
          let merged = mergeSuccPairs xs []
          in if length merged == 1
             then head merged
             else mergesort' merged
