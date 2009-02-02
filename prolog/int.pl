zero.

succ(zero).
succ(succ(X)) :- succ(X).

int(zero).
int(succ(X)) :- int(X).

equal(zero,zero).
equal(succ(X),succ(Y)) :- equal(X,Y).

plus_(X, zero, Y) :- equal(X,Y).
plus_(X, succ(Y), Z) :- plus_(A, Y, Z), equal(X, succ(A)).

num(X,zero) :- X=0.
num(X,succ(Y)) :- num(Z, Y), X is Z+1.
