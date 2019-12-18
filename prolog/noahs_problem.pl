staircase(0,[]).
staircase(Top, Moves) :- 
   Top > 0,
   step(Height),
   TopMinus1 is Top-Height,
   staircase(TopMinus1, List),
   append(List, [TopMinus1], Moves).


possible_stairs(Top, Possibilities) :- 
	aggregate_all(count, staircase(Top, Moves), Possibilities).
