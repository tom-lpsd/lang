import Char
import System
import Data.List

main = interact (concat . intersperse [' '] . (map (show . ord)))
