-module(hello).
-export([hello/1]).

hello(X) ->
    io:format("~p~n", X).
