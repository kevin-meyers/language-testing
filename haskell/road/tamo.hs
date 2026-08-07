module TAMO where


infixr 2 <+>
(<+>) :: Bool -> Bool -> Bool
x <+> y = x /= y


infix 1 <=>
(<=>) :: Bool -> Bool -> Bool
x <=> y = x == y

infix 1 ==>
(==>) :: Bool -> Bool -> Bool
True ==> x = x
False ==> x = True


formula :: Bool -> Bool -> Bool
formula p q = (not p) && (p ==> q) <=> not (q && (not p))

valid2 :: (Bool -> Bool -> Bool) -> Bool
valid2 f = and [f p q | p <- [True, False],
												q <- [True, False]]

contradiction2 :: (Bool -> Bool -> Bool) -> Bool
contradiction2 f = and [not (f p q) | p <- [True, False],
																		q <- [False, True]]
