data Term = Con Int | Div Term Term
newtype St a = MkSt (State -> (a, State))
type State = Int

apply :: St a -> State -> (a, State)
apply (MkSt f) s = f s

eval :: Term -> St Int
eval (Con x) = MkSt f
    where
      f s = (x, s)

eval (Div t u) = MkSt f
    where
      f s = (x `div` y, s''+1)
          where
            (x, s') = apply (eval t) s
            (y, s'') = apply (eval u) s'

instance Show a => Show (St a) where
    show f = "value: " ++ show x ++ ", count: " ++ show s
        where (x, s) = apply f 0
