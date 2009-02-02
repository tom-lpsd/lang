import Char
import Control.Monad

-- 3つの異るタイプの項をパースできます
data Parsed = Digit Integer | Hex Integer | Word String deriving Show

-- パースされた16進数の表現に一文字を追加する
parseHexDigit :: Parsed -> Char -> [Parsed]
parseHexDigit (Hex n) c = if isHexDigit c then
                            return (Hex ((n*16) + (toInteger (digitToInt c))))
                          else
                            mzero
parseHexDigit _       _ = mzero

-- パースされた10進数の表現に一文字を追加する
parseDigit :: Parsed -> Char -> [Parsed]
parseDigit (Digit n) c = if isDigit c then
                           return (Digit ((n*10) + (toInteger (digitToInt c))))
                         else
                           mzero
parseDigit _         _ = mzero
		   
-- パースされた単語表現に一文字を追加する
parseWord :: Parsed -> Char -> [Parsed]
parseWord (Word s) c = if isAlpha c then
                         return (Word (s ++ [c]))
                       else
                         mzero
parseWord _        _ = mzero

-- (数)字を16進数の値、10進数の値、単語の値としてパースすることを試みる
-- the result is a list of possible parses
parse :: Parsed -> Char -> [Parsed]
parse p c = (parseHexDigit p c) `mplus` (parseDigit p c) `mplus` (parseWord p c)

-- 文字列全体をパースし、可能なパース値のリストを返す
parseArg :: String -> [Parsed]
parseArg s = do init <- (return (Hex 0)) `mplus` (return (Digit 0)) `mplus` (return (Word ""))
                foldM parse init s
