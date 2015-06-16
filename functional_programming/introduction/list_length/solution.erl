-module(solution).
-export([main/0]).

read_list() ->
    case io:fread("", "~d") of
        {ok, [X]} ->
            [X | read_list()];
        eof ->
            []
    end.

count([]) ->
    0;
count([_|B]) ->
    1 + count(B).

main() ->
	L = read_list(),
    % L=[-1,-2,-3],
    C = count(L),
    io:format("~w~n", [C]).
