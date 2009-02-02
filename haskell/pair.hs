data Pair a b = MkPair a b
myfst (MkPair a b) = a
mysnd (MkPair a b) = b

test :: (a,b) -> Bool
test (x,y) = True

pair :: (a->b,a->c) -> a -> (b,c)
pair (f,g) x = (f x, g x)

cross :: (a->b,c->d) -> (a,c) -> (b,d)
cross (f,g) = pair (f.fst, g.snd)

