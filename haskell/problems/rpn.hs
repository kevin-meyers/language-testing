import Data.List (words)

main :: IO ()
main = putStrLn "Hello!"

rpn :: String -> Double
rpn = head . foldl (flip evaluate) [] . words

evaluate :: String -> [Double] -> [Double]
evaluate "*" = calculate (*)
evaluate "-" = calculate (-)
evaluate "+" = calculate (+)
evaluate "/" = calculate (/)
evaluate x = (read x :)

calculate :: (Double -> Double -> Double) -> [Double] -> [Double]
calculate f (x:y:xs) = f x y : xs
