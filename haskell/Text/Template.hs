module Text.Template (Template, TemplateValue(..), compile, process) where
import Data.Char
import qualified Data.HashTable as HT
import Text.Regex
import Text.Utils (split)

type Name = String
data Elem = Var Name | Raw String | End |
            If Name  | Foreach Name deriving (Show, Eq)

type Template = [Elem]
data TemplateValue = TemplVar String | TemplIf Bool | 
                     TemplFor [HT.HashTable String TemplateValue]

extractWord :: String -> String
extractWord = takeWhile (not.isSpace) . dropWhile isSpace

parseDirective :: String -> Elem
parseDirective str =
    case map toUpper directive of
      "IF" -> If (extractWord rest)
      "FOREACH" -> Foreach (extractWord rest)
      "END" -> End
      otherwise -> Var directive
    where
      body = dropWhile isSpace str
      (directive, rest) = break isSpace body

parse :: String -> Maybe [Elem]
parse ('%':str) = do (directive, other) <- divide str
                     return [parseDirective directive, Raw other]
parse str = Just [Raw ('[':str)]

divide :: String -> Maybe (String, String)
{- ex. " foo % bar %]baz" -> (" foo % bar ", "baz") -}
divide str = case break (=='%') str of
               (_, []) -> Nothing
               (h, _:']':t) -> Just (h, t)
               (h, t:ts) -> do (h', t') <- divide ts 
                               return (h ++ [t] ++ h', t')

compile :: String -> Maybe Template
compile [] = Nothing
compile str = do elems <- mapM parse rest
                 return $ (Raw first):concat elems
    where
      (first:rest) = split '[' str

process :: Template -> HT.HashTable String TemplateValue -> IO String
process tmpl hash = convert tmpl
    where
      msg1 = "There is not a value of template."
      convert [] = return ""
      convert (Var name:tt) = do val <- HT.lookup hash name
                                 rest <- convert tt
                                 case val of
                                   Just (TemplVar str) -> return (str ++ rest)
                                   otherwise -> fail msg1
      convert (Raw body:tt) = do rest <- convert tt
                                 return (body ++ rest)
      convert (If name:tt) = do val <- HT.lookup hash name
                                rest <- convert (tail remain)
                                body <- convert clause
                                case val of
                                  Just (TemplIf True) -> return (body ++ rest)
                                  Just (TemplIf False) -> return rest
                                  otherwise -> fail msg1
          where
            (clause, remain) = break (==End) tt
      convert (Foreach name:tt) = do val <- HT.lookup hash name
                                     rest <- convert (tail remain)
                                     case val of
                                       Just (TemplFor hs) -> mapM (process clause) hs >>= return.concat
                                       otherwise -> fail msg1
          where
            (clause, remain) = break (==End) tt
