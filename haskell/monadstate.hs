import Control.Monad.State

f :: (Num a, MonadState a m) => m a
f = do s <- get
       put $ s + 1
       return 10
