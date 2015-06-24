-module (solution).
-export ([main/0]).

sum([]) ->
    0;
sum([Ch | Rest]) ->
    Ch - 48 + sum(Rest).


super_digit(Str) ->
    S = sum(Str),
    % io:format("~p~n", [S]),
    if
        S =< 10 ->
            S;
        true ->
            super_digit(integer_to_list(S))
    end.


main() ->
    {ok, [Str, N]} = io:fread("", "~s~d"),
    S = sum(Str) * N,
    R = super_digit(integer_to_list(S)),
    io:format("~p~n", [R]).
