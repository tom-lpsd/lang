{-# LANGUAGE ForeignFunctionInterface #-}

import Foreign

foreign import ccall "hello.h hello" c_hello :: IO ()
