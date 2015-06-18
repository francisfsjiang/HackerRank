-module(solution).
-export([main/0]).


fib(S, N, N) ->
    {A,_} = S,
    A;
fib(S, M, N) ->
    {A,B} = S,
    fib({B, A+B}, M+1, N).

main() ->
	{ok, [N]} = io:fread("", "~d"),
    A = fib({0,1}, 1, N),
    io:format("~w~n", [A]).
