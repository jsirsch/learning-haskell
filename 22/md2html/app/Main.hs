module Main where

import CLI (cliParser)

main :: IO ()
main = do
    putStrLn "Hello, Haskell!"
    output <- cliParser
    putStrLn output