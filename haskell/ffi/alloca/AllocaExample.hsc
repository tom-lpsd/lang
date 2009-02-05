{-# INCLUDE "fill.h" #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module AllocaExample where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import Foreign.Marshal
import Data.Word

foreign import ccall "setString" c_set_string :: Ptr CString -> IO ()

foreign import ccall "fill" c_fill :: Ptr CChar -> CInt -> IO ()

set = do alloca $ \p -> do
           c_set_string p
           str <- (peek p >>= peekCString)
           putStr str

fill n = do allocaBytes (n+1) $ \p -> do
              c_fill p (fromIntegral n)
              peekCString p >>= putStrLn
