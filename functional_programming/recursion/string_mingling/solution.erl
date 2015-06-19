-module(solution).
-export([main/0]).

sm([], []) ->
    [];
sm([A|B], [C|D]) ->
    [A] ++ [C] ++ sm(B, D).


main() ->
    {ok, [S1, S2]} = io:fread("", "~s~s"),
    S = sm(S1, S2),
    io:format("~s~n", [S]).
