import Histogram
import System.IO
import System.Random
import System.Process
import Data.List

plot h hist = do hPutStrLn h "p '-' w boxes"
                 printHistogram h hist
                 hPutStrLn h "e"
                 hFlush h

averageRank :: [Int] -> [Double]
averageRank vals = 
    let sums = scanl1 (+) $ map fromIntegral vals
    in snd $ mapAccumL (\y r -> (r+1.0, (r + y)/2.0)) 1 sums

calcT :: [Int] -> [Int] -> Double
calcT xs ys
    = let diffs = filter (/=0) $ zipWith (-) xs ys
          aves = averageRank.map length.group.sort.map abs $ diffs
          (ps, ns) = partition (< 0) diffs
          ps' = map length.group.sort.map ((-1)*) $ ps
          ns' = map length.group.sort $ ns
      in min (sum $ zipWith (*) (map fromIntegral ps') aves) (sum $ zipWith (*) (map fromIntegral ns') aves)

makeTseq :: [Int] -> [Double]
makeTseq rands
    = let n = 100
          (xs, remain) = splitAt n rands
          (ys, remain') = splitAt n remain
      in calcT xs ys:makeTseq remain'

main = do hist <- makeHistogram 0 4000 100
          seed <- getStdGen
          (i,_,_,_) <- runInteractiveCommand "gnuplot"
          hPutStrLn i "set yrange [0:]"
          mapM_ ((>> plot i hist).(updateHistogram hist)) $ 
                makeData $ makeTseq $ randomRs (1, 5) seed
    where
      makeData lst = let (h,t) = splitAt 1000 lst in h:makeData t
