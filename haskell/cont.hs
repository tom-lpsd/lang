import Control.Monad.Cont

f :: Cont r Int
f = return 10

g :: Cont r String
g = return "foo"

h = do n <- f
       s <- g
       return (n, s)

ff = callCC $ \e -> do
       r <- h
       n <- callCC $ \e2 -> do
                      when (fst r < 20) (e 30)
                      return 2
       when (fst r < 20) (e 10)
       return (20+n)
