module Histogram where
import System.IO
import Data.Array.IO
import Data.Array.MArray

data Histogram = 
    Histogram { low :: Double, high :: Double, num :: Int,  
                frequencies :: IOUArray Int Int }

makeHistogram :: Double -> Double -> Int -> IO Histogram
makeHistogram low high num 
    = do ary <- newArray (0, num-1) 0
         return $ Histogram low high num ary

updateHistogram :: Real a => Histogram -> [a] -> IO ()
updateHistogram (Histogram l h n ary) dat = mapM_ (update ary.makeIndex) dat
    where
      width = (h-l) / (fromIntegral n)
      toDouble = fromRational . toRational
      makeIndex x = floor $ ((toDouble x) - l) / width
      minmax = getBounds ary
      update ary i = do (mi, ma) <- minmax
                        if (i < mi) || (i > ma)
                          then hPutStrLn stderr "our of range"
                          else readArray ary i >>= writeArray ary i . (+1)

printHistogram :: Handle -> Histogram -> IO ()
printHistogram handle (Histogram l h n ary) = 
    do (min, max) <- getBounds ary
       mapM_ printElement [min..max]
    where
      width = (h-l) / (fromIntegral n)
      toDouble = fromRational . toRational
      convertIndex i = l + width * (toDouble i + 0.5)
      printElement i = do x <- readArray ary i
                          hPutStrLn handle $ show (convertIndex i) ++ " " ++ show x
