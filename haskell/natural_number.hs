data Nat = Zero | Succ Nat

plus :: Nat -> Nat -> Nat
plus m Zero = m
plus m (Succ n) = Succ $ plus m n

mul :: Nat -> Nat -> Nat
mul m Zero = Zero
mul m (Succ n) = plus (mul m n) m

fact :: Nat -> Nat
fact Zero = Succ Zero
fact (Succ n) = mul (Succ n) (fact n)

fib :: Nat -> Nat
fib Zero = Zero
fib (Succ Zero) = Succ Zero
fib (Succ (Succ n)) = plus (fib (Succ n)) (fib n)

instance Show Nat where
    show Zero = "Zero"
    show (Succ Zero) = "Succ Zero"
    show (Succ (Succ n)) = "Succ (" ++ show (Succ n) ++ ")"

instance Eq Nat where
    Zero == Zero = True
    Zero == Succ n = False
    Succ m == Zero = False
    Succ m == Succ n = (m==n)

instance Ord Nat where
    Zero < Zero = False
    Zero < Succ n = True
    Succ m < Zero = False
    Succ m < Succ n = (m<n)

convert :: Nat -> Integer
convert Zero = 0
convert (Succ n) = (convert n) + 1
