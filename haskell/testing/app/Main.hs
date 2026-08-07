module Main where

import Lib
import Data.List (find)
import Data.Maybe (fromJust)

main :: IO ()
main = someFunc

largestRepackaged :: [Int] -> Int
largestRepackaged = max . map fst . foldl (\x acc -> (x + snd acc) `logRemainder` 2)
  where
    highestN :: Double -> Double
    highestN x = (/2) . fromJust $ find (> x) $ map (2**) [0..]

    logRemainder :: Double -> (Double, Double)
    logRemainder x = (,) <$> (x-) <*> highestN x
