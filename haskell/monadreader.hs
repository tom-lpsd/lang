{-# LANGUAGE GeneralizedNewtypeDeriving, FlexibleInstances,
             MultiParamTypeClasses #-}
import Control.Monad.Reader

newtype MyReader e a = R { runMyReader :: Reader e a } deriving (Monad)

instance MonadReader e (MyReader e) where
    ask = R $ Reader (\e -> )
