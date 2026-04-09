import SumNonEmpty

-- sum []
-- sum [1..3]

-- sumNonEmpty []
-- sumNonEmpty [1..3]

main :: IO ()
main = do
    putStrLn "Hi!"
    let result = sumNonEmpty []
    print result
    putStrLn "Bye!"