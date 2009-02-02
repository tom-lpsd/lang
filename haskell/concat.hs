import Prelude hiding (concat, (++))

(++) :: [a] -> [a] -> [a]
[] ++ ys = ys
(x:xs) ++ ys = x:(xs ++ ys)

concat :: [[a]] -> [a]
concat [] = []
concat (x:xs) = x ++ concat xs
