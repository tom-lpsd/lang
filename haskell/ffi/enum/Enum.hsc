{-# LANGUAGE CPP, ForeignFunctionInterface #-}

module Enum where

import Foreign
import Foreign.C.Types

#include "enum.h"

newtype EnumConst = Enum CInt deriving (Eq, Show)

#{enum EnumConst, Enum
 , bar = Bar
 , baz = Baz
}
