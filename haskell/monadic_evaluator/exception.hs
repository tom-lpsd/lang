data Term = Con Int | Div Term Term | Try Term Term deriving Show

data Exc a = Raise Exception | Return a
type Exception = String

instance Monad Exc where
    return x = Return x
    (Raise e) >>= q = Raise e
    (Return x) >>= q = q x

raise :: Exception -> Exc a
raise e = Raise e

eval :: Term -> Exc Int
eval (Con x) = return x
eval (Div t u) = do x <- eval t
                    y <- eval u
                    if y==0
                      then raise "division by zero"
                      else return (x `div` y)
eval (Try t u) = do let x = eval t
                    case x of
                      (Raise e) -> eval u
                      otherwise -> x


instance Show a => Show (Exc a) where
    show (Raise e) = "exception: " ++ e
    show (Return x) = "value: " ++ show x

