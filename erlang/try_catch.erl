-module(try_catch).
-export([bar/0]).

foo(a) ->
    throw({foo, bar}).

bar() ->
    try foo(a)
    catch
	throw:X ->
	    X
    end.
