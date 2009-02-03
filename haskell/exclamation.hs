data Foo = Foo Int !Int deriving Show

main = let f = Foo (1 `div` 0) 10 in f `seq` print "OK"
