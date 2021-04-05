female(eizabeth).
female(ann).
male(charles).
male(andrew).
male(edward).
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

successor(X,Y):-(male(X),female(Y),not(queen(Y)));(male(X),male(Y),is_elder(X,Y));(female(X),female(Y),is_elder(X,Y)).

insert(X,[Y|Z],[Y|W]):-not(is_elder(X,Y)),!,insert(X,Z,W).
insert(X,Z,[X|Z]).
successionSort([X|Y],Sorting):- successionSort(Y,TailOfList), insert(X,TailOfList,Sorting).
successionSort([],[]).

successionList(X,SuccessorList):- findall(Y,child(X,Y),Children),successionSort(Children,SuccessorList).
