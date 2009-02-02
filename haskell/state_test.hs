import Control.Monad.State

foo :: Int -> State Int Int
foo a = State (\x -> (a*10, (x+1)))

bar = do foo 100
         foo 100
         a <- foo 200
         put (a+1)
         foo 100
         foo 100
         b <- get
         foo b
         mapM_ (\x -> foo 0) [1..10]

