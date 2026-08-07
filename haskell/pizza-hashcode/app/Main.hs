{-# LANGUAGE TypeApplications #-}

module Main where

import System.IO
import Control.Applicative

import Lib

main :: IO ()
main = withFile "a_example.txt" ReadMode $ \file -> do
  (numPizzas:teams) <- map (read @Int) . words <$> hGetLine file
  pizzaMap <- mapM (\_ -> tail . words <$> hGetLine file) [1..numPizzas]
  case teams of
      (twos:threes:fours:_) -> print =<< (teamsToSendTo numPizzas twos threes fours :: IO [Int])


{-|
I think I first want to pick the teams to send pizzas to.
Since I know that we need to (or should?) use all the pizzas, I will start from 4's and
move down in team size as necessary until I find the "largest" possible combination of teams to fit the number of pizzas.

Ex. if there was 1 team of 2, 3, and 4. And we had 5 pizzas, first try subtracting 4, then 3 etc if it invalidates then try another route. 
-}

teamsToSendTo :: Alternative f => Int -> Int -> Int -> Int-> f [Int]
teamsToSendTo numPizzas twos threes fours = teamsToSendTo' numPizzas twos threes fours
  where
      teamsToSendTo' numPizzas' twos' threes' fours'
          | numPizzas' < 0 = empty
          | numPizzas' == 0 = pure [twos - twos', threes - threes', fours - fours']
          | otherwise = 
                teamsToSendTo' (numPizzas' - 4) twos' threes' (fours'-1)
            <|> teamsToSendTo' (numPizzas' - 3) twos' (threes'-1) fours'
            <|> teamsToSendTo' (numPizzas' - 2) (twos'-1) threes' fours'


checkLeftRight :: [Int] -> [Int]
checkLeftRight xs = checkLeftRight' 1 $ xs ++ [1]
  where
    checkLeftRight' _ [_] = []
    checkLeftRight' x (y:z:rest) = (if x == 1 && z == 1 then 0 else y) : checkLeftRight' y (z : rest)
