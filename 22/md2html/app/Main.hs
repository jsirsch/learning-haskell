{-# LANGUAGE RecordWildCards #-}

module Main where

import              CLI             (Options (..), cliParser)
import qualified    Data.Text.IO    as TIO
import Control.Monad (when)

main :: IO ()
main = do
    Options{..} <- cliParser
    fileContent <- TIO.readFile inputFile
    when verbose $ do
        mapM_ print ["-------------------------------------------"
                    ,"Parsing this input file: " ++ inputFile
                    ,"Writing result to output file: " ++ outputFile
                    ,"-------------------------------------------"
                    ,"File Content:"
                    ,show fileContent
                    ]