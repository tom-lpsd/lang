-module(hello).
-export([fac/1, last/1, 
         lookup/2, append/2, sort/1]).

fac(N) when N > 0 -> N * fac(N-1);
fac(0)            -> 1.

last([First]) -> First;
last([_|Rest]) -> last(Rest).

append([], List) -> List;
append([First|Rest], List) -> [First | append(Rest, List)].

sort([]) -> [];
sort([Pivot|T]) -> 
    sort([X||X <- T, X < Pivot]) ++
    [Pivot] ++
    sort([X||X <- T, X > Pivot]).

lookup(Key, {Key1, Val, Left, Right}) when Key == Key1 ->
    Val;
lookup(Key, {Key1, Val, Left, Right}) when Key < key1 ->
    lookup(Key, Left);
lookup(Key, {Key1, Val, Left, Right}) when Key > Key1 ->
    lookup(Key, Right).
