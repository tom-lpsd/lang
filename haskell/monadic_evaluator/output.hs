data Term = Con Int | Div Term Term | Trace Term | Untrace Term deriving Show

newtype Out a = MkOut (a, (Bool -> (Bool, Output)))
type Output = String

instance Monad Out where
    return x = MkOut (x, (\s -> (s, "")))
    p >>= q = MkOut (y, f')
        where
          MkOut (x, f) = p
          MkOut (y, g) = q x
          f' s = (s'', ox++oy)
              where
                (s', ox) = f s
                (s'', oy) = g s'

out :: Output -> Out ()
out ox = MkOut ((), (\s -> if s then (True, ox) else (False, "")))

line :: Term -> Int -> Output
line t x = "term: " ++ show t ++ ", yields " ++ show x ++ "\n"

eval :: Term -> Out Int
eval (Con x) = do out(line (Con x) x)
                  return x
eval (Div t u) = do x <- eval t
                    y <- eval u
                    out (line (Div t u) (x `div` y))
                    return (x `div` y)
eval (Trace t) = do MkOut (0, (\s -> (True, "")))
                    x <- eval t                    
                    MkOut (0, (\s -> (not s, ""))) 
                    return x

eval (Untrace t) = do MkOut (0, (\s -> (False, "")))
                      x <- eval t
                      MkOut (0, (\s -> (not s, ""))) 
                      return x

instance Show a => Show (Out a) where
    show (MkOut (x, f)) = ox ++ show x
        where (_, ox) = f False
