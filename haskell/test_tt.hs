import Text.Template

main = do text <- getContents
          putStrLn $ output text [("foo","bar")]
