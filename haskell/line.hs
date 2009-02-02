import List
data Line = L {number::Int, string::String} deriving Show

sortLines = sortBy (\L {number=a} L {number=b} -> a `compare` b)
