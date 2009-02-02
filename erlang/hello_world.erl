-module(hello_world).
-export([hello_world/1]).

hello_world(X) ->
    io:format("Hello, World!~p~n", X).

main(_) ->
    io:format("Hello, world!~n").
