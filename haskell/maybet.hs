import Data.Maybe
import Control.Monad
import Control.Monad.Trans

newtype MaybeT m a = MaybeT {
      runMaybeT :: m (Maybe a)
    }

bindMT :: (Monad m) => MaybeT m a -> (a -> MaybeT m b) -> MaybeT m b

x `bindMT` f = MaybeT $ runMaybeT x >>= maybe (return Nothing) (runMaybeT . f)

returnMT :: (Monad m) => a -> MaybeT m a
returnMT x = MaybeT $ return (Just x)

failMT :: (Monad m) => t -> MaybeT m a
failMT _ = MaybeT $ return Nothing

instance (Monad m) => Monad (MaybeT m) where
    return = returnMT
    (>>=) = bindMT
    fail = failMT

instance MonadTrans MaybeT where
    lift m = MaybeT (Just `liftM` m)

foo :: MaybeT IO Int
foo = do x <- lift getLine
         when (read x < 10) $ fail "< 10"
         y <- lift getLine
         return (read x + read y)


bar :: IO (Maybe Int)
bar = do x <- liftM read getLine
         if x < 10
           then return mzero
           else do y <- liftM read getLine
                   return $ return (x + y)
