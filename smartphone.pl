company(sumsum).
company(appy).
developer(galactic-s3,appy).
smartPhone(galactic-s3,sumsum).
person(stevey).
competitor(sumsum,appy).
boss(stevey,sumsum).
stoleIdea(boss(stevey,sumsum),developer(galactic-s3,appy)).

business(T,C):-smartPhone(T,C).
rival(C):-competitor(C,appy);competitor(appy,C).
unethical(B,C,D,T):-boss(B,C),rival(C),business(T,C),stoleIdea(boss(B,C),developer(T,D)).

