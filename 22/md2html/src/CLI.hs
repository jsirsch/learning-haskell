module CLI where

import Options.Applicative

parserInfo :: ParserInfo String
parserInfo = info options infoModifiers

options :: Parser String
options =
    strOption
        (   short 'i'
        <>  long "input"
        <>  help "Input file to process"
        <>  metavar "INPUT_FILE"
        )

infoModifiers :: InfoMod String
infoModifiers = fullDesc
    <> progDesc "Process an input file and write results to an output file"
    <> header "CLI Tool - A simple command line interface for file processing"


cliParser :: IO String
cliParser = execParser parserInfo