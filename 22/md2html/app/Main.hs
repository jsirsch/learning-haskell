module Main where

import CLI (cliParser)

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"
    result <- cliParser
    print result