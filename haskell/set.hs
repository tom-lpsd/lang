findp x [] = False
findp x (y:ys)
    | x == y = True
    | otherwise = findp x ys

nodup [] = []
nodup (x:xs) = x:(nodup $ erase x xs)
    where
      erase x [] = []
      erase x (y:ys)
          | x == y = (erase x ys)
          | otherwise = y:(erase x ys)

-- HaskellのListモジュールでは以下のように定義されているらしい
--   nub              :: (Eq a) => [a] -> [a]
--   nub []           =  []
--   nub (x:xs)       =  x : nub (filter (\y -> not (x == y)) xs)

intersection [] ys = []
intersection (x:xs) ys 
    | findp x ys = x:(intersection xs ys) 
    | otherwise   = intersection xs ys

