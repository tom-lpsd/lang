import Char
data MyType = I Int | F Float | C Char deriving Show

filterC [] = []
filterC (C x:xs) = (C x):filterC xs
filterC (x:xs) = filterC xs

sumI [] = 0
sumI (I x:xs) = x + (sumI xs)
sumI (x:xs) = sumI xs

mySum [] = 0
mySum (I x:xs) = x + mySum xs
mySum (F x:xs) = truncate x + mySum xs
mySum (C x:xs) = ord x + mySum xs
