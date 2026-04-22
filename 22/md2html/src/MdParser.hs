module MdParser where

import Control.Monad
import Text.Megaparsec
import Data.Void
import Data.Text ( Text )
import Text.Megaparsec.Char

type MDParser = Parsec Void Text

data MdElem
    = PlainText Text
    | Italic MdElem
    | Bold MdElem
    | Heading Int MdElem
    | Paragraph [MdElem]
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

parseHeading :: MDParser MdElem
parseHeading = label "heading" $ do
    level <- length <$> some (char '#')
    when (level > 6) $
        fail "heading level must be between 1 and 6"
    space1
    Heading level <$> parseLine

parseParagraph :: MDParser MdElem
parseParagraph = label "paragraph" $ do
    skipMany space1
    elements <- some parseLine
    skipMany space1
    pure $ Paragraph elements