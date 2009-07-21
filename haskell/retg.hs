class Foo a where
    foo :: Int -> a

data Bar = Bar Int deriving Show

instance Foo Bar where
    foo n = Bar n

data Baz = Baz Int String deriving Show

instance Foo Baz where
    foo n = Baz n (show n)
