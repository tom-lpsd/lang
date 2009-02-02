howManyEqual2 x y 
    | x == y = 2
    | otherwise = 0

howManyEqual3 x y z
    | x == y && y == z = 3
    | x == y || x == z || y == z = 2
    | otherwise = 0

weakAscendingOrder :: Int -> Int -> Int -> Bool
weakAscendingOrder m n p = m <= n && n <= p


between :: Int -> Int -> Int -> Bool
between x y z
    | weakAscendingOrder x y z = x <= y && y <= z
    | otherwise = x >= y && y >= z

howManyEqual x y z
    | between x y z = (howManyEqual2 x y) + (howManyEqual2 y z) - (if x==z then 1 else 0)
    | otherwise = howManyEqual2 x z
