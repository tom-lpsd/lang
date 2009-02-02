-module(test).
-export([test/0, test/1,test/2]).

test() -> io:format("no args~n").
test(X) -> io:format("~p~n", [X]).
test(X, Y) -> io:format("~p~n", [X]),
	      io:format("~p~n", [Y]).
