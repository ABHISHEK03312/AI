% factorial(0,1).
  
% factorial(A,B) :-  
%            A > 0, 
%            C is A-1,
%            factorial(C,D),
%            B is A*D. 

ask(0):- queryActivity([eat]).


/* Check if activity, Y, is in list did. If yes, execute answerYes. If no execute answerNo */ 
checkAnswer(Y) :- 
	did(Y), answerYes(Y); answerNo(0).


/* If chosen activity not performed by child, get list L of activities. Ask question based upon list L */ 
answerNo(0) :- optionsActivity(L), queryActivity(L).
/* Find activity based upon random */ 
optionsActivity(L) :- findnsols(100,X,random(X),L).
/* Check if there are no more activities to ask about. If yes, end code. */
queryActivity([]) :- print('No more questions').
/* Ask about activity, L, and add activity to either 'did' or 'didNot' based upon answer */
queryActivity(L) :-
	print(L), print("Did you"), member(X,L), print(X), print('? y/n/q: '), read(Answer), (Answer==q -> abort;Answer==y -> assert(did(X));assert(didNot(X))), checkAnswer(X).
	

/* If chosen activity performed by child, get list of related follow up questions (L) corresponding to activity Y */ 
/* Ask follow up question based upon list L */
answerYes(Y) :- optionsFirstFollowUp(Y, L), queryFollowUp(L).
/* Finds list L of related follow up questions corresponding to activty Y */
optionsFirstFollowUp(Y, L) :- findnsols(100, X, related(Y,X), L).


/* Finds list of follow up questions, L, related to the previous follow up question Y */
/* Ask follow up questin based upon list L */ 
askFollowUp(Y) :- optionsFollowUp(Y, L), queryFollowUp(L).
/* Find list of related follow up questions, L, based upon previous follow up question, Y, using relatedFollowUp*/
optionsFollowUp(Y, L) :- findnsols(100, X, relatedFollowUp(Y,X), L).


/* Finds all objects in list 'asked', convert the list to set*/ 
/* Remove objects in list asked from list\object L result is Remainging. Checks if Remaining is empty*/ 
queryFollowUp(L) :- 
	findnsols(100,X,asked(X),Asked), list_to_set(L,S), list_to_set(Asked,A), subtract(S,A,Remaining), checkRemaining(Remaining). 


/* Checks input list is empty, by pattern match */
/* If empty, no more follow up questions, ask about another activity */
checkRemaining([]) :- answerNo(0).
/* If not empty, ask follow up question and add question to 'asked'*/
checkRemaining(R) :- member(X,R), print(X), print('? y/n/q: '), read(Answer), (Answer==q -> abort;assert(asked(X))), askFollowUp(X).


/* Finds rule to execute based upon pattern match of first input variable */ 
/* Returns object X which is a random member of the list corresponding to first input variable. */
related(eat, X):- eat(L),random_member(X, L).
related(play, X):- play(L),random_member(X, L).
related(sing, X):- sing(L),random_member(X, L).
related('play games', X):- game(L),random_member(X, L).
related(behave, X):- behave(L),random_member(X, L).
related(talk, X):- talk(L),random_member(X, L).
related(learn, X):- learn(L),random_member(X, L).
related('ride a bike', X):- bike(L),random_member(X, L).
related('skip ropes', X):- rope(L),random_member(X, L).


/* Finds object X, which is a member of the same list as object Y  */ 
relatedFollowUp(Y, X) :- 
	eat(L),member(X,L),member(Y,L);
	play(L),member(X,L),member(Y,L);
	sing(L),member(X,L),member(Y,L);
	game(L),member(X,L),member(Y,L);
	behave(L),member(X,L),member(Y,L);
	talk(L),member(X,L),member(Y,L);
	learn(L),member(X,L),member(Y,L);
	bike(L),member(X,L),member(Y,L);
	rope(L),member(X,L),member(Y,L).


/* Removes already asked about activities from list activity. */
/* Returns random activity from Remaining objects i.e from list Remaining */
random(Y) :- activity(A), findnsols(100,X,did(X),DidList), findnsols(100,X,didNot(X),DidNotList), append(DidList,DidNotList,History), list_to_set(A,S), list_to_set(History,H), subtract(S,H,Remaining), random_member(Y, Remaining).


/* List of activities */ 
activity([eat, play, sing, 'play games', behave, talk, learn, 'ride a bike', 'skip ropes']).
/* Lists of follow up questions based upon activity */
eat(['was it spicy', 'did you use a spoon', 'was it sweet', 'was it salty', 'was it yummy']).
play(['did you play football', 'did you play basketball', 'did you play pirates', 'did you play floorball']).
sing(['did you sing let it go' ,'did you sing ipsy dipsy spider', 'did you sing the ABC-song']).
game(['hungry hippos', cards, monopoly, 'did you win']).
behave(['did you say thank you', 'did you say please' , 'did you help clean up']).
talk(['about pokemon', 'about the weather', 'about lego']).
learn([counting, reading, spelling]).
bike(['did you fall', 'did you wear a helmet']).
rope(['was it fun']).

/* lists of activities done, not done */
did(nothing).
didNot(nothing).
/* List of follow up questions asked */
asked(nothing).