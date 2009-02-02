import Data.Array.MArray
import Data.Array.IO
import Control.Monad.State

incr :: IOUArray Int Int -> Int -> IO ()
incr e i = do x <- readArray e i
              writeArray e i (x+1)

up :: Int -> State (IO (IOUArray Int Int)) Int
up i = State (\e -> (i, do { e' <- e; incr e' i; return e' }))

trig = mapM_ up [0..9]

