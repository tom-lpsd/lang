import Data.List
import Control.Arrow

split :: Char -> String -> [String]
split delim = takeWhile (not . null) . unfoldr (Just . (second $ drop 1) . break (==delim))

main = do text <- getContents
          mapM_ putStr $ split '[' text
