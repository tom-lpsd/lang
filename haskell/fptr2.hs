import Database.TokyoCabinet.HDB

fib = 1:1:(zipWith (+) fib (tail fib))

h = let f = fib !! 100000
    in f `seq` 1

main = do
  hdb <- new
  open hdb "foo.tch" [oWRITER, oCREAT]
  putStrLn . show $ h
