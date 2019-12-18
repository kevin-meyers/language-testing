word(astante,  a,s,t,a,n,t,e).
word(astoria,  a,s,t,o,r,i,a).
word(baratto,  b,a,r,a,t,t,o).
word(cobalto,  c,o,b,a,l,t,o).
word(pistola,  p,i,s,t,o,l,a).
word(statale,  s,t,a,t,a,l,e).

crossword(V1, V2, V3, H1, H2, H3) :-
	word(V1, V1_1, V1H1, V1_3, V1H2, V1_5, V1H3, V1_7),
	word(V2, V2_1, V2H1, V2_3, V2H2, V2_5, V2H3, V2_7),
	word(V3, V3_1, V3H1, V3_3, V3H2, V3_5, V3H3, V3_7),
	word(H1, H1_1, V1H1, H1_3, V2H1, H1_5, V3H1, H1_7),
	word(H2, H2_1, V1H2, H2_3, V2H2, H2_5, V3H2, H2_7),
	word(H3, H3_1, V1H3, H3_3, V2H3, H3_5, V3H3, H3_7).
