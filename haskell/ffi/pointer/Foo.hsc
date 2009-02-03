{-# LANGUAGE CPP, ForeignFunctionInterface #-}
{-# INCLUDE foo.h #-}
module Foo where

import Foreign
import Foreign.Ptr
import Foreign.C.Types

newtype CFoo = CFoo (Ptr CFoo)

foreign import ccall unsafe "init"
    c_init :: CInt -> CInt -> IO (Ptr CFoo)

foreign import ccall "wrapper"
    c_FooFunc :: (Ptr CFoo -> IO ()) -> IO (FunPtr (Ptr CFoo -> IO ()))

foreign import ccall unsafe "destroy"
    c_destroy :: Ptr CFoo -> IO ()

data Foo = Foo !(ForeignPtr CFoo)

main = putStrLn "OK"

fooInit :: Int -> Int -> IO Foo
fooInit x y = do f <- c_init (fromIntegral x) (fromIntegral y)
                 finalizer <- c_FooFunc c_destroy
                 p <- newForeignPtr finalizer f
                 return (Foo p)
