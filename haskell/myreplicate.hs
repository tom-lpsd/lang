myreplicate 0 x = []
myreplicate n x 
    | n<0 = []
    | otherwise = x:myreplicate (n-1) x

mycycle xs = xs ++ (mycycle xs)
