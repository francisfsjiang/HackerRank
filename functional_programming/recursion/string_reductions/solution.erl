-module(solution).
-export([main/0]).

reduction(_, []) ->
    ok;
reduction(Table, [Ch | RestStr]) ->
    Flag = ets:lookup(Table, Ch),
    if
        Flag == [] ->
            ets:insert(Table, {Ch}),
            io:format("~c", [Ch]),
            reduction(Table, RestStr);
        true ->
            reduction(Table, RestStr)
    end.

main() ->
    {ok, [Str]} = io:fread("", "~s"),
    Table = ets:new(redu, [set]),
    reduction(Table, Str).
