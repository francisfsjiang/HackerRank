-module(solution).
-export([main/0]).

read_list(y) ->
    case io:fread("", "~d") of
        {ok, [X]} ->
            [X | read_list(n)];
        eof ->
            []
    end;
read_list(n) ->
    case io:fread("", "~d") of
        {ok, [_]} ->
            read_list(y);
        eof ->
            []
    end.

print([]) ->
    ok;
print([A|B]) ->
    io:format("~p~n",[A]),
    print(B).

main() ->
    L = read_list(n),
    print(L).
