data Term = Con Int | Div Term Term

eval :: Term -> Int
eval (Con x) = x
eval (Div t u) = (eval t) `div` (eval u)
