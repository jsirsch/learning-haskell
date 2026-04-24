{-# LANGUAGE RecordWildCards #-}

module Main where

import              CLI             (Options (..), cliParser)
import qualified    Data.Text.IO    as TIO
import Control.Monad (when)
import MdParser (mainParser)
import Text.Megaparsec (runParser)
import ToHTML (toHTML)


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
    case runParser mainParser inputFile fileContent of
        Left err -> print err
        Right elems -> do
            when verbose $ do
                print "-------------------------------------------"
                print "Parsed elements:"
                print elems
            let html = toHTML elems
            when verbose $ do
                print "-------------------------------------------"
                print "HTML:"
                print html
            TIO.writeFile outputFile html