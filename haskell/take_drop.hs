import Prelude hiding (take, drop, splitAt)

take :: Int -> [a] -> [a]
take 0 _ = []
take _ [] = []
take n (x:xs) 
    | n < 0 = []
    | otherwise = x:take (n-1) xs

drop :: Int -> [a] -> [a]
drop 0 lst = lst
drop _ [] = []
drop n lst@(x:xs)
    | n < 0 = lst
    | otherwise = drop (n-1) xs

splitAt :: Int -> [a] -> ([a], [a])
splitAt 0 lst = ([], lst)
splitAt _ [] = ([], [])
splitAt n lst@(x:xs)
    | n < 0 = ([], lst)
    | otherwise = let (h,t) = splitAt (n-1) xs 
                  in (x:h, t)

inits :: [a] -> [[a]]
inits [] = [[]]
inits (x:xs) = [] : (map (x:) $ inits xs)

tails :: [a] -> [[a]]
tails [] = [[]]
tails lst@(_:xs) = lst : tails xs

