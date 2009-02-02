import Control.Monad.Reader

data Template = T String | V Template | 
                Q Template | I Template [Definition] | 
                C [Template] deriving Show
data Definition = D Template Template deriving Show

-- 環境は名前付きテンプレートの連想リストと名前付きの変数値の
-- 連想リストで構成されています
data Environment = Env {templates::[(String,Template)],
                        variables::[(String,String)]}

-- 環境から変数を探索
lookupVar :: String -> Environment -> Maybe String
lookupVar name env = lookup name (variables env)

-- 環境からテンプレートを探索
lookupTemplate :: String -> Environment -> Maybe Template
lookupTemplate name env = lookup name (templates env)

-- 環境に解決された定義のリストを追加
addDefs :: [(String,String)] -> Environment -> Environment
addDefs defs env = env {variables = defs ++ (variables env)}
                      
-- Definition を解決し、(name,value) の組を生成
resolveDef :: Definition -> Reader Environment (String,String)
resolveDef (D t d) = do name <- resolve t
                        value <- resolve d
                        return (name,value)

-- テンプレートを解決し文字列にする
resolve :: Template -> Reader Environment (String)
resolve (T s)    = return s
resolve (V t)    = do varName  <- resolve t
                      varValue <- asks (lookupVar varName)
		      return $ maybe "" id varValue
resolve (Q t)    = do tmplName <- resolve t
                      body     <- asks (lookupTemplate tmplName)
                      return $ maybe "" show body 
resolve (I t ds) = do tmplName <- resolve t
                      body     <- asks (lookupTemplate tmplName)
                      case body of
                        Just t' -> do defs <- mapM resolveDef ds
                                      local (addDefs defs) (resolve t')
                        Nothing -> return ""
resolve (C ts)   = (liftM concat) (mapM resolve ts)
