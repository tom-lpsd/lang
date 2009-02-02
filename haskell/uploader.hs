import List
import Text.Regex
import System.IO
import System.Environment

data ContentBody =  ContentBody 
    { disposition :: Maybe String,
      contentType :: Maybe String,
      params:: Maybe [(String, String)], 
      body :: String }

instance Show ContentBody where
    show con = "Disposition: " ++ (showCon $ disposition con) ++ 
               "Content-Type: " ++ (showCon $ contentType con) ++ 
               "Params: " ++ (showCons $ params con) 


showCon (Just s) = s ++ "\n"
showCon Nothing = "none\n"

showCons (Just s) = (concatMap (\x -> (show x) ++ ", ") s) ++ "\n"
showCons Nothing = "none\n"

separate :: String -> ([String], [String])
separate c = (hd, tail body)
    where 
      (hd, body) = break (== "\r") $ lines $ drop 2 c

decompHead :: [String] -> [(String, String)]
decompHead hd = hs'
    where
      hs = map (break (== ':')) hd
      hs' = map (\(x, y) -> (x, (init.(drop 2)) y)) hs

decompParam :: String -> [(String, String)]
decompParam [] = []
decompParam str = (x, init v):decompParam w
    where 
      (x, y) = break (=='=') $ drop 2 str
      (v, w) = break (==';') $ drop 2 y

analyze :: String -> ContentBody
analyze c = ContentBody { disposition = dis,
                          contentType = lookup "Content-Type" hs,
                          params = params,
                          body = unlines body }
    where
      (hd, body) = separate c
      hs = decompHead hd
      (dis, params) = case (lookup "Content-Disposition" hs) of
                        Just x -> f $ break (==';') x
                        Nothing -> (Nothing, Nothing)
      f (a,b) = (Just a, Just (decompParam b))


makeContent :: String -> String -> [ContentBody]
makeContent cs ctype = map analyze bodies
    where
      ctypes = splitRegex (mkRegex "boundary=") ctype
      bound = ctypes !! 1
      bodies = init . tail $ splitRegex (mkRegex ("--" ++ bound)) cs

printEnv :: IO ()
printEnv = do envs <- getEnvironment
              mapM_ (\(x,y) -> putStrLn (x++"="++y)) envs

save :: String -> String -> IO ()
save name body = do fh <- openFile name WriteMode
                    hPutStr fh ((init.init) body)
                    putStr "OK"

writeContents :: ContentBody -> IO ()
writeContents cont = 
    case (params cont) of 
      Just x -> case (lookup "filename" x) of
                  Just x' -> save x' $ body cont
                  Nothing -> return ()
      Nothing -> return ()

main :: IO ()
main = do putStrLn "Content-type: text/plain\n"
	  method <- getEnv "REQUEST_METHOD"
          ctype <- getEnv "CONTENT_TYPE"
          cs <- if method == "POST"
	         then getContents
                 else getEnv "QUERY_STRING"
          let contents = makeContent cs ctype
          mapM_ writeContents contents
--          putStr $ concatMap show contents
       `catch` (\e -> putStrLn $ show e)

