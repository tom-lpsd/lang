{-# LANGUAGE ForeignFunctionInterface #-}
import Foreign.Storable
import Foreign.Marshal
import Foreign.Ptr
import Foreign.ForeignPtr
import System.IO

fib = 1:1:(zipWith (+) fib (tail fib))

main = do
  n <- new 'f'
  f <- goFunc $ \p -> do
         free p
         poke p 'g'
         putStrLn "freed"
         hFlush stdout
         return ()
  p <- newForeignPtr f n
  peek n >>= putStrLn . show

  putStrLn . show $ h
  peek n >>= putStrLn . show

g fp = withForeignPtr fp $ \p -> do
  let !q = fp
  putStrLn . show $ h
  return ()

g' fp = withForeignPtr fp $ \p -> do
          putStrLn "g'"

h = let f = fib !! 100000
    in f `seq` 1

foreign import ccall "wrapper"
  goFunc :: (Ptr a -> IO ()) -> IO (FunPtr (Ptr a -> IO ()))
