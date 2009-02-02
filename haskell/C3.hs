module Main where
import Data.List
import Data.Maybe

data Syms = A | B | C | D | E | F | G | O deriving (Eq, Show)
data Class = Class { name :: Syms, parents :: [Class] }

instance Show Class where
    show = show . name

extract :: [[Syms]] -> Maybe Syms
extract syms_list = let ss = filter (not . null) syms_list
                        tls = map tail ss
                        hds = map head ss
                    in case find isJust $ map (flip extract' tls) hds of
                         Just x -> x
                         _ -> Nothing
    where
      extract' s tls = if all (notElem s) tls then Just s else Nothing

extracts :: [[Syms]] -> Maybe [Syms]
extracts [] = Just []
extracts ss 
    | all null ss = Just []
    | otherwise = do x <- extract ss
                     y <- extracts (map (filter (/= x)) ss)
                     return (x : y)

merge :: Class -> Maybe [Syms]
merge (Class self []) = Just [self]
merge (Class self parents) = do x <- mapM merge parents
                                y <- extracts $ x ++ [map name parents]
                                return (self : y)

f :: Class
f = Class F []

e :: Class
e = Class E []

d :: Class
d = Class D []

c :: Class
c = Class C [d, f]

b :: Class
b = Class B [e, d]

a :: Class
a = Class A [b, c]

main :: IO ()
main = (putStrLn . show . merge) a

