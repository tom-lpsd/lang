result(X,'E') :- even(X).
result(X,'O'):- odd(X).
even(X) :- integer(X), 0 is (X mod 2).
odd(X) :- integer(X), not(0 is (X mode 2)).
not(P) :- P,!,fail.
not(X).
