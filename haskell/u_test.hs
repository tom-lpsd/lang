import System.IO
import System.Process
import System.Random
import Data.Array.IO
import Data.Array.MArray
import Data.List

data Histogram = 
    Histogram { low :: Double, high :: Double, num :: Int,  
                frequencies :: IOUArray Int Int }

makeHistogram :: Double -> Double -> Int -> IO Histogram
makeHistogram low high num 
    = do ary <- newArray (0, num-1) 0
         return $ Histogram low high num ary

toDouble :: Real a => a -> Double
toDouble = fromRational . toRational

updateHistogram :: Real a => Histogram -> [a] -> IO ()
updateHistogram (Histogram l h n ary) dat = mapM_ (update ary.makeIndex) dat
    where
      width = (h-l) / (fromIntegral n)
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
      convertIndex i = l + width * (toDouble i + 0.5)
      printElement i = do x <- readArray ary i
                          hPutStrLn handle $ show (convertIndex i) ++ " " ++ show x

plot h hist = do hPutStrLn h "p '-' w boxes"
                 printHistogram h hist
                 hPutStrLn h "e"
                 hFlush h

averageRank vals = 
    let sums = scanl1 (+) vals
    in snd $ mapAccumL (\y r -> (r+1, (fromIntegral r + fromIntegral y)/2.0)) 1 sums

calcU :: ([Int], Int, [Int], Int) -> Double
calcU (xs, n1, ys, n2) = 
    let mapPair f (x,y) = (f x, f y)
        (xsums, ysums) = mapPair (map length.group.sort) (xs, ys)
        aves = averageRank $ zipWith (+) xsums ysums
        (n1', n2') = mapPair fromIntegral (n1, n2)
        r1 = sum $ zipWith (*) (map fromIntegral xsums) aves
        r1max = n1' * n2' + n1' * (n1' + 1.0) / 2.0
    in  (r1max-r1)

makeData :: Int -> Int -> [Int] -> ([Int], [Int], [Int])
makeData n1 n2 lst 
    = let (x, y) = splitAt n1 lst
          (z, w) = splitAt n2 y
      in (x, z, w)

makeUseq rands
    = let (n1, n2) = (40, 40)
          (x, y, z) = makeData n1 n2 rands
      in calcU (x, n1, y, n2):makeUseq z

makeNseq rands
    = let (x, y) = splitAt 100 rands
      in (sum x):makeNseq y

makeChiseq rands
    = let (x, y) = splitAt 5 rands
      in sum (map (**2) x):makeChiseq y

main = do hist <- makeHistogram 100 1500 100
          seed <- getStdGen
          (i,_,_,_) <- runInteractiveCommand "gnuplot"
          hPutStrLn i "set yrange [0:]"
          mapM_ ((>> plot i hist).(updateHistogram hist)) $ 
                split $ makeUseq $ randomRs (1, 5) seed
    where
      split lst = let (h,t) = splitAt 100 lst in h:split t
