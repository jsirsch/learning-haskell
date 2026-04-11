import Forest.Level1 ( Forest(..), level1Forest )
import User.Actions.Move ( AvailableMoves, move )

main :: IO ()
main = do
    putStrLn "🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲"
    putStrLn "🌲🌲🌲🌲🌲🌲🌲🌲🌲 Forest Game 🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲"
    putStrLn "🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲🌲"
    putStrLn "You're traped in a Forest, try to escape! Remember that you loose stamina with each step you take."
    gameLoop (10 :: Int, level1Forest)
  where
    gameLoop (_, Exit) = putStrLn "CONGRATULATIONS! You escaped!"
    gameLoop (s, _) | s <= 0 = putStrLn "You ran out of stamina and died -.-! GAME OVER!"
    gameLoop (s, forest) = do
        putStrLn $  "You have " ++ show s ++ " stamina, and you are still in the Forest. Choose a path, brave adventurer: GoLeft, GoForward, GoRight."
        selectedMove <- getLine
        gameLoop $ move (s, forest) (read selectedMove :: AvailableMoves)
