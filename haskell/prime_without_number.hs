import System

data Nat = Zero | Succ Nat

instance Eq Nat where
    Zero == Zero = True
    Succ _ == Zero = False
    Zero == Succ _ = False
    Succ n == Succ m
        | n == m = True
        | otherwise = False

instance Ord Nat where
    compare Zero Zero = EQ
    compare Zero (Succ _) = LT
    compare (Succ _) Zero = GT
    compare (Succ n) (Succ m) = compare n m

minus :: Nat -> Nat -> Nat
minus Zero Zero = Zero
minus (Succ n) Zero = Succ n
minus (Succ n) (Succ m) = minus n m

incr :: Nat -> Nat
incr Zero = Succ Zero
incr n = Succ n

divisible :: Nat -> Nat -> Bool
divisible n m
    | n < m = False
    | (minus n m) == Zero = True
    | otherwise = divisible (minus n m) m

isPrime :: Nat -> Bool
isPrime Zero = False
isPrime (Succ Zero) = False
isPrime n = isPrime' n (Succ (Succ Zero))
    where
      isPrime' n m
          | n == m = True
          | otherwise = if divisible n m then False else isPrime' n (incr m)

isZero :: Int -> Bool
isZero n = (negate n) == n

numToNat :: Int -> Nat
numToNat n = numToNat' n Zero
    where
      numToNat' n m
          | isZero n = m
          | otherwise = numToNat' (pred n) (incr m)

main :: IO ()
main = do args <- getArgs
          putStrLn $ show (isPrime $ numToNat.read $ head args)
