module SumNonEmpty where

data MyData a b = Error a | Result b deriving Show

sumNonEmpty :: Num a => [a] -> MyData String a
sumNonEmpty [] = Error "List is empty"
sumNonEmpty xs = Result (sum xs)
