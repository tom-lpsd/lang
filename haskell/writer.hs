import Control.Monad.Writer

foo :: (Num a) => Writer (Sum a) Int
foo = do tell (Sum 0)
         return 10
         
