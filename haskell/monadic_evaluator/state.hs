data Term = Con Int | Div Term Term | Count deriving Show

newtype St a = MkSt (State -> (a, State))
type State = Int

instance Monad St where
    return x = MkSt f where f s = (x, s)
    p >>= q = MkSt f
        where
          f s = apply (q x) s'
              where (x, s') = apply p s

tick :: St ()
tick = MkSt f where f s = ((), s+1)

apply :: St a -> State -> (a, State)
apply (MkSt f) s = f s

eval :: Term -> St Int
eval (Con x) = return x
eval (Div t u) = do x <- eval t
                    y <- eval u
                    tick
                    return (x `div` y)
eval Count = MkSt f
    where f s = (s, s)

instance Show a => Show (St a) where
    show f = "value: " ++ show x ++ ", state: " ++ show s
        where (x, s) = apply f 0
