-module(solution).
-export([main/0]).

generate_list(0) ->
    [];
generate_list(N) ->
    [1 | generate_list(N-1)].



main() ->
    {ok, [N]} = io:fread("", "~d"),
    Arr = generate_list(N),
    io:format("~B~n", [length(Arr)]).
