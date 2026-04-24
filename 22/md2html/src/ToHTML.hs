module ToHTML where

import Data.Text (Text)
import qualified Data.Text as T
import MdParser (ListItem(..), MdElem(..))

showT :: Show a => a -> Text
showT = T.pack . show

toHTML :: [MdElem] -> Text
toHTML = foldr (\el acc -> elemToHTML el <> acc) ""
    where
        elemToHTML :: MdElem -> Text
        elemToHTML (PlainText text)     = text
        elemToHTML (Italic el)          = "<em>" <> elemToHTML el <> "</em>"
        elemToHTML (Bold el)            = "<strong>" <> elemToHTML el <> "</strong>"
        elemToHTML (Paragraph elements) = "<p>" <> toHTML elements <> "</p>"
        elemToHTML (Heading lvl el)     = "<h" <> showT lvl <> ">" <> elemToHTML el <> "</h" <> showT lvl <> ">"
        elemToHTML (OrderedList items)  = 
            "<ol>" <> foldr (\(ListItem elements) acc -> "<li>" <> toHTML elements <> "</li>" <> acc) "" items <> "</ol>"
        elemToHTML (UnorderedList items) =
            "<ul>" <> foldr (\(ListItem elements) acc -> "<li>" <> toHTML elements <> "</li>" <> acc) "" items <> "</ul>"
