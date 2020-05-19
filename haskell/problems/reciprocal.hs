import Data.List (findIndex, maximumBy)
import Data.Maybe (fromJust)

ninesList :: [Integer]
ninesList = map (9*) $ scanl (\acc x-> (10^x)+acc) 1 [1..]


getLengthOfReciprocal :: Integer -> Int
getLengthOfReciprocal n = fromJust $ findIndex (\x -> x `rem` n == 0) ninesList

longestLength :: Int
longestLength = fst $ foldr updateAcc (1, 0) $ filter (not . (`factorOf` 5)) [3, 5..1000]

factorOf :: Int -> Int -> Bool
factorOf x y = x `rem` y == 0

updateAcc :: Int -> (Int, Int) -> (Int, Int)
updateAcc x (maxX, maxLength)
 | xLength > maxLength = (x, xLength)
 | otherwise = (maxX, maxLength)
	where
		xLength = getLengthOfReciprocal $ fromIntegral x
