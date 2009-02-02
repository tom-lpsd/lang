import Text.Template
import Data.HashTable


vals = [("foo", TemplVar "100"), ("bar", TemplIf True)]

main = do body <- getContents
          let tmpl = compile body
          forhash1 <- new (==) hashString
          insert forhash1 "foo" (TemplVar "foo1")
          insert forhash1 "x" (TemplIf True)
          forhash2 <- new (==) hashString
          insert forhash2 "foo" (TemplVar "foo2")
          insert forhash1 "x" (TemplIf False)
          hash <- fromList hashString vals
          insert hash "baz" (TemplFor [forhash1, forhash2])
          case tmpl of
            Just tmp -> process tmp hash >>= putStr
--            Just tmp -> putStrLn $ show tmp
            Nothing -> putStrLn "Nothing"

