import System.IO
import System.Posix.IO
import System.Process

createPipeHandle :: IO (Handle, Handle)
createPipeHandle = do (o, i) <- createPipe
                      ih <- fdToHandle i
                      oh <- fdToHandle o
                      return (oh, ih)

main = do (o,i) <- createPipeHandle
          h <- (runProcess "cat" [] Nothing Nothing (Just stdin) (Just i) Nothing)
          s <- hGetLine o
          putStrLn s
          waitForProcess h
