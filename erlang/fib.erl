-module(fib).
-export([fib/1,fib/2]).
-export([cfib/1]).
-export([dfib/1]).
-export([fibsvr/0, fibclt/1]).
-export([cfibsvr/0, cfibclt/1]).
-export([wait_for_result/1, wait_for_cfibsvr/1]).

fib(0) -> 1;
fib(1) -> 1;
fib(X) -> fib(X-1) + fib(X-2).

fib(0, P) -> P ! 1;
fib(1, P) -> P ! 1;
fib(X, P) -> P ! fib(X-1) + fib(X-2).

cfib(0) -> 1;
cfib(1) -> 1;
cfib(X) ->
    S = self(),
    spawn(fib, fib, [X-1, S]),
    spawn(fib, fib, [X-2, S]),
    wait_for_result([], 0).

dfib(0) -> 1;
dfib(1) -> 1;
dfib(X) ->
    S = self(),
    spawn('node1@kame', fib, fib, [X-1, S]),
    spawn('node2@ayu', fib, fib, [X-2, S]),
    wait_for_result([], 0).

fibsvr() ->    
    receive
	{0, P} when is_pid(P) ->
	    P ! 1,
	    fibsvr();
	{1, P} when is_pid(P) ->
	    P ! 1,
	    fibsvr();
	{X, P} when is_pid(P) ->
	    P ! fib(X-1) + fib(X-2),
	    fibsvr();
	terminate -> terminate
    end.

fibclt(X) ->
    IsALIVE = whereis(fibsvr),
    if
	IsALIVE == undefined ->
	    register(fibsvr, spawn(fib, fibsvr, []));
	true -> ok
    end,
    fibsvr ! {X, self()},
    receive
	R -> R
    end.

cfibsvr() ->
    receive
	{0, P} when is_pid(P) ->
	    P ! 1,
	    cfibsvr();
	{1, P} when is_pid(P) ->
	    P ! 1,
	    cfibsvr();
	{X, P} when is_pid(P), X < 24 ->
	    P ! fib(X-1) + fib(X-2),
	    cfibsvr();
	{X, P} when is_pid(P) ->
	    W = spawn(fib, wait_for_result, [P]),
	    spawn(fib, fib, [X, W]),
	    cfibsvr();
	terminate -> terminate
    end.

wait_for_result(P) ->
    receive
	Res -> P ! Res
    end.

%%% wait_for_result(L, 2) -> lists:sum(L);
%%% wait_for_result(L, N) ->
%%%     receive
%%% 	Res -> L2 = lists:append(L, [Res]),
%%% 	       wait_for_result(L2, N+1)
%%%     end.

