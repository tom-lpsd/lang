import Data.Array.MArray
import Data.Array.IO

foo :: IO (IOUArray Int Int)
foo = newArray (0, 10) 0

incElem :: IOUArray Int Int -> Int -> IO ()
incElem e i = do x <- readArray e i
                 writeArray e i (x+1)

main :: IO ()
main = do ary <- foo
          elems <- getElems ary
          putStrLn $ show elems
          x <- readArray ary 1
          writeArray ary 1 (x + 1)
          incElem ary 3
          incElem ary 3
          incElem ary 10
          elems <- getElems ary
          putStrLn $ show elems

