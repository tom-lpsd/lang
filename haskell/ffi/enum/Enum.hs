{-# INCLUDE "enum.h" #-}
{-# LINE 1 "Enum.hsc" #-}
{-# LANGUAGE CPP, ForeignFunctionInterface #-}
{-# LINE 2 "Enum.hsc" #-}

module Enum where

import Foreign
import Foreign.C.Types


{-# LINE 9 "Enum.hsc" #-}

newtype EnumConst = Enum CInt deriving (Eq, Show)

bar  :: EnumConst
bar  = Enum 10
baz  :: EnumConst
baz  = Enum 11

{-# LINE 16 "Enum.hsc" #-}
