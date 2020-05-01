module GS where

divides :: Integer -> Integer -> Bool
divides d = (== 0) . flip rem d

ld :: Integer -> Integer
ld = ldf 2

ldf :: Integer -> Integer -> Integer
ldf k n
  | divides k n = k
  | k ^ 2 > n = n
  | otherwise = ldf (k + 1) n

prime0 :: Integer -> Either String Bool
prime0 n
  | n < 1 = Left "not a positive Integer."
  | n == 1 = Right False
  | otherwise = Right $ ld n == n

removeFst :: (Ord a) => [a] -> a -> [a]
removeFst [] _ = []
removeFst (x:xs) y
  | x == y = xs
  | otherwise = x : removeFst xs y

countChar :: Char -> String -> Int
countChar _ [] = 0
countChar c (x:xs)
  | c == x = 1 + countChar c xs
  | otherwise = countChar c xs

countChar' :: Char -> String -> Int
countChar' = (length .) . filter . (==)

blowUp :: String -> String
blowUp s = tailBlowUp s 1
  where
    tailBlowUp "" _ = ""
    tailBlowUp (x:xs) i = replicate i x ++ tailBlowUp xs (i + 1)

minList :: (Ord a) => [a] -> a
minList [x] = x
minList (x:xs) = foldr min x xs

srtString :: [String] -> [String]
srtString = selectionSort

selectionSort :: (Ord a) => [a] -> [a]
selectionSort [] = []
selectionSort [x] = [x]
selectionSort xs = m : selectionSort (removeFst xs m)
  where
    m = minList xs

isPrefixOf :: String -> String -> Bool
isPrefixOf "" _ = True
isPrefixOf [_] "" = False
isPrefixOf (x:xs) (y:ys)
  | x == y = xs `isPrefixOf` ys
  | otherwise = False

isSubstringOf :: String -> String -> Bool
isSubstringOf _ "" = False
isSubstringOf xs ys
  | xs `isPrefixOf` ys = True
  | otherwise = xs `isSubstringOf` tail ys

primeFactors :: Integer -> [Integer]
primeFactors n
  | n < 1 = error "not factorable"
  | n == 1 = []
  | otherwise = p : primeFactors (n `div` p)
  where
    p = ld n
