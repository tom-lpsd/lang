myfoldl f a [] = a
myfoldl f a (x:xs) = myfoldl f (f a x) xs

myfoldr f a [] = a
myfoldr f a (x:xs) = f x (myfoldr f a xs)

myreverse [] = []
myreverse (x:xs) = (myreverse xs) ++ [x]

-- fold function in Scheme language.
fold _ init [] = init
fold f init (x:xs) = fold f (f x init) xs
