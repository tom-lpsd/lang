module Main where
import Graphics.UI.WX

main :: IO ()
main
  = start hello

hello :: IO ()
hello
  = do f     <- frame    [text := "Hello!"]
       hello <- button f [text := "hello", on command := (putStrLn "Hello, World!")]
       quit  <- button f [text := "Quit", on command := close f]
       set f [layout := margin 10 (column 5 [floatCentre (widget hello)
                                            ,floatCentre (widget quit)
                                            ] )]
