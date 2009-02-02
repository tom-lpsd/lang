import Control.Monad

schedule = 
    do let d1 = 30 -- 最初の月の日数
           d2 = 31 -- 次の月の日数
           w1 = 4  -- 最初の土曜の日付
       w' <- [w1, w1+7 .. (d1 + d2)] -- 2カ月分の土曜のリスト
       w  <- (\x -> [x, x+1]) w' -- 2カ月分の土日のリスト
       -- 最初の月の17日までか，次の月
       guard $ not $ (\x -> 18 <= x  && x < d1) w
       -- 最初の月の4日ではない
       guard (w /= 4)
       -- 最初の月か，次の月の10日，24日，31日のいずれか
       guard $ w < d1 || w == 10 + d1 || w == 24 + d1 || w == 31 + d1
       let dates = if w < d1 
                     then w
                     else w - d1
       -- 31日でも11日でもない
       guard $ dates /= 31 && dates /= 11
       return dates