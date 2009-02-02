data Term = Con Int | Div Term Term deriving Show

eval :: Monad m => Term -> m Int
eval (Con x) = return x
eval (Div t u) = do x <- eval t
                    y <- eval u
                    return (x `div` y)

newtype Id a = MkId a

instance Monad Id where
    return x = MkId x
    (MkId x) >>= q = q x

instance Show a => Show (Id a) where
    show (MkId x) = "value: " ++ show x

evalId :: Term -> Id Int
evalId = eval


data Count a = Cnt (a, Int) deriving Show

instance Monad Count where
    return x = Cnt (x, 0)
    p >>= q = Cnt (y, cnt + cnt')
        where
          Cnt (x, cnt) = p
          Cnt (y, cnt') = q x

evalCnt :: Term -> Count Int
evalCnt (Con x) = Cnt (x, 0)
evalCnt (Div t u) = do x <- evalCnt t
                       y <- evalCnt u
                       Cnt (0, 1)
                       return (x `div` y)
