data Term = Con Int | Div Term Term deriving Show
newtype Out a = MkOut (Output, a)
type Output = String

eval (Con x) = MkOut (line (Con x) x, x)
eval (Div t u) = MkOut (ox ++ oy ++ line (Div t u) z, z)
    where MkOut (ox, x) = eval t
          MkOut (oy, y) = eval u
          z = x `div` y

line :: Term -> Int -> Output
line t x = "term: " ++ show t ++ ", yields " ++ show x ++ "\n"

instance Show a => Show (Out a) where
    show (MkOut (ox, x)) = ox ++ "value: " ++ show x
