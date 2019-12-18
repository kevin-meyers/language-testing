module Main where

main :: IO ()

main = do
  putStrLn (greet "world")

greet name = "hello " ++ name ++ "!"
