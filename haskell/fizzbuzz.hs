data FizzBuzz a = FizzBuzz (String, a)

instance (Show a) => Show (FizzBuzz a) where
    show (FizzBuzz ("",x)) = show x
    show (FizzBuzz (m, x)) = m

instance Monad FizzBuzz where
    return x = FizzBuzz ("", x)
    p >>= q = FizzBuzz (m ++ m' , x')
        where
          FizzBuzz (m, x) = p
          FizzBuzz (m', x') = q x

rule n s = (\x -> FizzBuzz $ if (x `mod` n) == 0 then (s, x) else ("", x))

fizzbuzz = map (\x -> return x >>= (rule 3 "Fizz") >>= (rule 5 "Buzz"))
