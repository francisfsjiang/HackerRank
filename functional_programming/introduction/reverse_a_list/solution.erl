-module(solution).
-export([main/0]).

rev([]) ->
    [];
rev([A|B]) ->
    lists:append(rev(B), [A]).

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
	L = rev(read_list()),
    print(L).
