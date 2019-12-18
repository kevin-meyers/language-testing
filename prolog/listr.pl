printr(List) :-
	[L|Y] = List,
	writeln(L),
	printr(Y).
