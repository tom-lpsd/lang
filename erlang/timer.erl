-module(timer).
-export([timer/1]).

timer2(T) ->
    receive
    after T ->
      io:format("OK~n")
    end.

timer(T) -> spawn(fun() -> timer2(T) end).