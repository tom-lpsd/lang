xor1 :: Bool -> Bool -> Bool
xor1 x y = (x == True) && (y == False) || (x == False) && (y == True)

xor2 :: Bool -> Bool -> Bool
xor2 True False = True
xor2 False True = True
xor2 _ _ = False

nand :: Bool -> Bool -> Bool
nand x y = not (x && y)
