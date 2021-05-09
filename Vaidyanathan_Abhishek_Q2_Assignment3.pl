ask(0):-	print("Hey....how are you ? "), validateAndQuery(['Did you eat spicy food']).
ask(Y):-
	generate_options(Y,L), validateAndQuery(L).

generate_options(Y,L):-
	did(Y), print("Great... "), findnsols(100,X,related_activity(X,Y),L);
	print("Well... how about... "), findnsols(100,X,random_activity(X),L).

validateAndQuery(L):-
	findnsols(100,X,did(X),DidList), findnsols(100,X,didNot(X),DidNotList), 
	append(DidList,DidNotList,History), list_to_set(L,S), list_to_set(History,H), subtract(S,H,Valid), member(X,Valid), 
	print(X), print('? y/n/q: '), read(Did), (Did==q -> abort;Did==y -> assert(did(X));assert(didNot(X))), ask(X).
	
related_activity(X,Y):- 
	eat(L),member(X,L),member(Y,L);
	play(L),member(X,L),member(Y,L);
	friends(L),member(X,L),member(Y,L);
	homework(L),member(X,L),member(Y,L);
	games(L),member(X,L),member(Y,L).

random_activity(X):-
	eat(A), play(B), friends(C), homework(D), games(E),
	append(A,B,AB), append(AB,C,ABC), append(ABC,D,ABCD), append(ABCD,E,ABCDE), random_member(X,ABCDE).

eat(['Did you eat spicy food','Did you eat sweet food','did you wash your hands after eating','did you finish your food']).
play(['did you play basketball','do you play football','do you like cricket','Did you injure yourself','did you drink enough water while playing']).
friends(['did you enjoy with your friends','did you play games with your friends','are all of your friends fine']).
homework(['do you have homework','Have you completed your homework','how much time will it take to complete your homework ','when is the submission for your homework']).
games(['did you play cards','did you play monoploly','did you play crossword']).

did(nothing).
didNot(nothing).
a.