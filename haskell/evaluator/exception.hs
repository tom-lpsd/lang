data Term = Con Int | Div Term Term
data Exc a = Raise Exception | Return a
type Exception = String

eval :: Term -> Exc Int
eval (Con x) = Return x
eval (Div t u)
         = h (eval t)
           where
             h (Raise e) = Raise e
             h (Return x) = h' (eval u)
                 where
                   h' (Raise e') = Raise e'
                   h' (Return y)
                      = if y == 0
                        then Raise "division by zero"
                        else Return (x `div` y)

instance Show a => Show (Exc a) where
    show (Raise e) = "exception: " ++ e
    show (Return x) = "value: " ++ show x
