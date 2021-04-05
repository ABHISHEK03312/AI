% % takeout(A,[A|B],B).
% % takeout(X,[B|C],[B|Y]) :-
% %     takeout(X,C,Y).

% % del[Y,[Y],[]].
% % del(X,[X|LIST1],LIST1).
% % del(X,[Y|LIST],[Y|LIST1]):-del(X,LIST,LIST1).
% % insert(A,[B|C],[B|D]):- not(is_older(A,B)),!,insert(A,C,D).
% % insert(A,C,[A|C]).

% male(charles).
% male(andrew).
% male(edward).
% female(elizabeth).
% female(ann).
% offspring(charles,elizabeth).
% offspring(andrew,elizabeth).
% offspring(ann,elizabeth).
% offspring(edward,elizabeth).
% elder_than(charles,ann).
% elder_than(ann,andrew).
% elder_than(andrew,edward).

% %%declare new predicate to propagate birth order
% is_older(X,Y):- elder_than(X,Y).
% is_older(X,Y):- elder_than(X,Z),is_older(Z,Y).

% %%Original order by gender
% precedes(X,Y):- male(X),male(Y),is_older(X,Y).
% precedes(X,Y):- male(X),female(Y), Y\=elizabeth.
% precedes(X,Y):- female(X), female(Y),is_older(X,Y).

% %%Sorting algorithm
% %insert(A,[B|C],[B|D]):- not(precedes(A,B)),!,insert(A,C,D).
% %%New succession rule "insert"
% insert(A,[B|C],[B|D]):- not(is_older(A,B)),!,insert(A,C,D).
% insert(A,C,[A|C]).
% succession_sort([A|B],SortList):- succession_sort(B,Tail), insert(A,Tail,SortList).
% succession_sort([],[]).

% successionList(X,SuccessionList):- findall(Y,offspring(Y,X),ChildNodes),succession_sort(ChildNodes,SuccessionList).

% all_greater_than_zero([]).
% all_greater_than_zero([H|4],Y) :- Y is H*H,H>0.
%     % all_greater_than_zero(T).
insert(A,[B,C],[B,D]).
insert(A,[B,C],[B,D]):-insert(A,C,D).

successor_new(X,Y):-(male(X),male(Y),isolder(X,Y));(female(X),male(Y),isolder(X,Y),not(queen(X)));(male(X),female(Y),isolder(X,Y),not(queen(Y)));(female(X),female(Y),isolder(X,Y),not(queen(X)),not(queen(Y))).
select(A, [A|B], B).
select(A, [B, C|D], [B|E]):-
    select(A, [C|D], E).
delete(A, [A|B], B).
delete(A, [B, C|D], [B|E]):-
    delete(A, [C|D], E).


successor_new(X,Y):-(male(X),male(Y),is_elder(X,Y));(female(X),male(Y),is_elder(X,Y),not(queen(X)));(male(X),female(Y),is_elder(X,Y),not(queen(Y)));(female(X),female(Y),is_elder(X,Y),not(queen(X)),not(queen(Y))).

append(Y,W,A,L1):-successor_new(Y,W),!,append([Y],A,L1).

is_reverse(X,Y):-reverse(X,L0),L0=Y.
succession_list(X,SuccessionList,A):-   
    [Y|Z] = SuccessionList,
    [W|_] = Z,
    child(X,Y),child(X,W),
    append(Y,W,A,L1),
    succession_list(X,Z,L1).

successors(X,SuccessionList,A):-
    (not(succession_list(X,SuccessionList,A)),
    (([_|L1]=A),(L1,A,Z),queen(X),reverse(Z,L0))),(L0=SuccessionList).
