import Control.Concurrent (forkIO, newEmptyMVar, takeMVar, putMVar)

putFoo m 0 = putStrLn "Foo" >> putMVar m "Foo End"
putFoo m n = putStrLn "Foo" >> putFoo m (n-1)

putBar m 0 = putStrLn "Bar" >> putMVar m "Bar End"
putBar m n = putStrLn "Bar" >> putBar m (n-1)

main = do m <- newEmptyMVar
          n <- newEmptyMVar
          forkIO $ putFoo m 20
          forkIO $ putBar n 100
          msg1 <- takeMVar m
          msg2 <- takeMVar n
          putStrLn msg1
          putStrLn msg2
