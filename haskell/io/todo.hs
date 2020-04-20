import Control.Exception (bracketOnError)
import Data.List (delete, lines, unlines, zipWith)
import System.Directory (removeFile, renameFile)
import System.Environment (getArgs)
import System.IO (appendFile, hClose, hPutStr, openTempFile, readFile)

dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "view" = view
dispatch "remove" = remove
dispatch "bump" = bump

main :: IO ()
main = do
  (command:argList) <- getArgs
  dispatch command argList

add :: [String] -> IO ()
add [fileName, toDoItem] = appendFile fileName $ toDoItem ++ "\n"

view :: [String] -> IO ()
view [fileName] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks =
        zipWith (\n line -> show n ++ " - " ++ line) [0 ..] todoTasks
  putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, index] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks =
        zipWith (\n line -> show n ++ " - " ++ line) [0 ..] todoTasks
  putStrLn "These are your TODO items:"
  let number = read index
      newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
  mapM_ putStrLn $ lines newTodoItems
  bracketOnError
    (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
       hClose tempHandle
       removeFile tempName)
    (\(tempName, tempHandle) -> do
       hPutStr tempHandle newTodoItems
       hClose tempHandle
       removeFile fileName
       renameFile tempName fileName)

bump :: [String] -> IO ()
bump [fileName, index] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      bumped = todoTasks !! read index
      newTodoItems = unlines $ bumped : delete bumped todoTasks
  putStrLn "New Todo list looks like:"
  mapM_ putStrLn $ lines newTodoItems
  bracketOnError
    (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
       hClose tempHandle
       removeFile tempName)
    (\(tempName, tempHandle) -> do
       hPutStr tempHandle newTodoItems
       hClose tempHandle
       removeFile fileName
       renameFile tempName fileName)
