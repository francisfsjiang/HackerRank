-module(solution).
-export([main/0]).

rev([]) ->
    [];
rev([A,B|S]) ->
    [B, A] ++ rev(S).

solve(0) ->
    ok;
solve(N) ->
    {ok, [S]} = io:fread("", "~s"),
    io:format("~s~n", [rev(S)]),
    solve(N-1).

main() ->
    {ok, [N]} = io:fread("","~d"),
    solve(N).
