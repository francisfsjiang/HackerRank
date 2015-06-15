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

my_filter(_, []) ->
    [];
my_filter(Fun, [A|B]) ->
    case Fun(A) of
        true ->
            [A | my_filter(Fun, B)];
        _ ->
            my_filter(Fun, B)
    end.

main() ->
    {ok, [D]} = io:fread("", "~d"),
    L = read_list(),
    FL = my_filter(fun(X) -> X < D end, L),
    print(FL).
