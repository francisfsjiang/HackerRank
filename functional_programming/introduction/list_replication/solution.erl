-module(solution).
-export([main/0]).

generate(_,0) ->
    [];
generate(X,N) ->
    io:format("~p~n", [X]),
    generate(X,N-1).

solve(N)->
    case io:fread("", "~d") of
        {ok, [X]} ->
            generate(X,N),
            solve(N);
        eof ->
            ok
    end.

main() ->
    {ok, [N]} = io:fread("", "~d"),
    solve(N).
