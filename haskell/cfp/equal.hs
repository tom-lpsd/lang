threeEqual :: Int -> Int -> Int -> Bool
threeEqual m n p = (m==n) && (n==p)

fourEqual m n p q = (m==n) && (n==p) && (p==q)

{- another implementation

fourEqual m n p q = (threeEqual m n p) && (m == q)

-}
