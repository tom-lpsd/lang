import Control.Monad.Reader

mysequence ms = foldr k (return []) ms
    where
      k m m' = do x <-m
                  xs <- m'
                  return (x:xs)

foo = do putStr "foo"
         putStrLn "bar"

a = Reader (\e -> e + 1)
b = Reader (\e -> e + 2)

c = sequence [a, b]
