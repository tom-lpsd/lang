-module(area_server).
-export([start/0, loop/1]).

start() ->
    spawn(area_server, loop, [0]).

loop(Tot)->
    receive
        {Client, {square, X}} ->
           Client ! X*X,
           loop(Tot + X*X);
        {Client, {rectangle, X, Y}} ->
           Client ! X*Y,
           loop(Tot + X*Y);
        {Client, areas} ->
           Client ! Tot,
           loop(Tot)
    end.
