-module(solution).
-export([main/0]).


fact(0) ->
    1;
fact(N) ->
    N * fact(N-1).

eval(_, 0) ->
    1;
eval(X,Times) ->
    math:pow(X, Times) / fact(Times) + eval(X, Times-1).

solve(0) ->
    ok;
solve(N) ->
    {ok, [X]} = io:fread("", "~f"),
    R = eval(X, 9),
    io:format("~.4f~n", [R]),
    solve(N-1).


main() ->
	{ok, [N]} = io:fread("", "~d"),
    solve(N).
