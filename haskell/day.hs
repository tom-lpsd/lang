data Day = Sun | Mon | Tue | Wed | Thu | Fri | Sat deriving (Eq,Ord,Enum)

pair :: (a->b,a->c) -> a -> (b,c)
pair (f,g) x = (f x, g x)

-- ２引数の関数から，ペアを受け取る関数に変換
myuncurry f x = f (fst x) (snd x)

-- 平日ならTrueを返す
workday = myuncurry (&&).pair ((Mon <=),(<= Fri))

