-module(solution).
-export([main/0]).

read_list() ->
    case io:fread("", "~d") of
        {ok, [X]} ->
            [X | read_list()];
        eof ->
            []
    end.

print([]) ->
    ok;
print([A|B]) ->
    io:format("~p~n",[A]),
    print(B).


main() ->
	L = read_list(),
    % L=[-1,-2,-3],
    C = lists:map(fun(X) ->
        case X < 0 of
            true -> -X;
            _ -> X
        end end, L),
    print(C).
