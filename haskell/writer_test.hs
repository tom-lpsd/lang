import Control.Monad.Writer

foo :: (Num a) => Writer (Sum a) Int
foo = return 0
