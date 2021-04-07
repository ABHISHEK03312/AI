queen(elizabeth).
child(elizabeth,charles).
child(elizabeth,ann).
child(elizabeth,andrew).
child(elizabeth,edward).

elderSibling(charles,ann).
elderSibling(ann,andrew).
elderSibling(andrew,edward).

is_elder(X,Y):-elderSibling(X,Y).
is_elder(X,Y):-
    elderSibling(X,Z),
    is_elder(Z,Y).

successor(X,Y):-
    (child(elizabeth,X),child(elizabeth,Y),not(queen(X)),not(queen(Y)),is_elder(X,Y)).

order_successors( ChildList, Sorted ) :-orderofsuccessors( ChildList, [], Sorted).

orderofsuccessors( [], A, A ).
orderofsuccessors( [H|T], A, Sorted ) :-bubble( H, T, NT, Max ),orderofsuccessors( NT, [Max|A], Sorted ).

bubble(X,[],[],X).
bubble( X, [Y|T], [Y|NT], Max ) :- not(successor( X, Y )),	bubble( X, T, NT, Max ).
bubble( X, [Y|T], [X|NT], Max ) :- successor( X, Y ),	bubble( Y, T, NT, Max ).

successionList( X, ListOfSuccessors ) :- 
	findall( Y, child( X, Y), ChildList ),
	order_successors( ChildList, ListOfSuccessors ), 
	write( ListOfSuccessors ).