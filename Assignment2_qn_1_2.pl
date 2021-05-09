company(sumsum).
company(appy).
developer(galactic-s3,sumsum).
smartPhone(galactic-s3).
competitor(sumsum,appy).
boss(stevey).
stoleIdea(boss(stevey),developer(galactic-s3,sumsum)).

rival(C):-competitor(C,appy);competitor(appy,C).
business(T):-smartPhone(T).
unethical(B,C,T):-company(C),rival(C),business(T),stoleIdea(boss(B),developer(T,C)).

