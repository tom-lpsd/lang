-module(receiver).
-export([receiver/0]).

receiver() ->
    receive
	Msg -> io:format("~necho: ~p", [Msg]),
	       receiver()
    end.
