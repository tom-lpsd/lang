mysequence_ :: (Monad m) => [m a] -> m ()
mysequence_ = foldr (>>) (return ())

mymapM :: (Monad m) => (a -> m b) -> [a] -> m [b]
mymapM f xs = sequence (map f xs)

mymapM_ :: (Monad m) => (a -> m b) -> [a] -> m()
mymapM_ f xs = sequence_ (map f xs)

myfoldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a
myfoldM f a [] = return a
myfoldM f a (x:xs) = (f a x) >>= (\y -> myfoldM f y xs)

myfoldM_ :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m ()
