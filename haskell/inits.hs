import List

myinits xs = [] : sub 1 xs
    where sub n xs
              | n == (length xs) = [xs]
              | otherwise = (take n xs) : sub (n + 1) xs

mytails [] = [[]]
mytails xs = xs : mytails (drop 1 xs)

myzip [] [] = []
myzip (x:xs) (y:ys) = (x,y) : myzip xs ys

myzipWith f [] [] = []
myzipWith f (x:xs) (y:ys) = f x y : myzipWith f xs ys

mysum = foldl (+) 0
myproduct = foldl (*) 1

myand = foldl (&&) True
myor = foldl (||) False

myunwords xs = intersperse " " xs