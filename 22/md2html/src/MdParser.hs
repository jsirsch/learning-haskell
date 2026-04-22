module MdParser where

import Text.Megaparsec
import Data.Void
import Data.Text ( Text )

type MDParser = Parsec Void Text

data MdElem
    = PlainText Text
    | Italic MdElem
    | Bold MdElem
    deriving (Show, Eq)

parseText :: MDParser MdElem
parseText = PlainText <$> takeWhile1P (Just "plain text") (`notElem` ['*', '_', '\n'])

parseItalic :: MDParser MdElem
parseItalic = label "italic text" $ do
    Italic <$> (between (chunk "*") (chunk "*") parseLine
           <|>  between (chunk "_") (chunk "_") parseLine)

parseBold :: MDParser MdElem
parseBold = label "bold text" $ do
    Bold <$> (between (chunk "**") (chunk "**") parseLine
         <|>  between (chunk "__") (chunk "__") parseLine)

parseLine :: MDParser MdElem
parseLine =
    choice
        [ parseBold
        , parseItalic
        , parseText
        ]