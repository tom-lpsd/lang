data MyEither a b = MyLeft a | MyRight b

mycase :: (a->c, b->c) -> MyEither a b -> c
mycase (f,g) (MyLeft x) = f x
mycase (f,g) (MyRight x) = g x

myplus :: (a->b, c->d) -> MyEither a c -> MyEither b d
myplus (f,g) = mycase (MyLeft .f , MyRight .g)
