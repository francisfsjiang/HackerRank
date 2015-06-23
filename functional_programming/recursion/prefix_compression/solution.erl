-module(solution).
-export([main/0]).


prefix([], RestStr2, Prefix) ->
    {Prefix, [], RestStr2};
prefix(RestStr1, [], Prefix) ->
    {Prefix, RestStr1, []};
prefix([], [], Prefix) ->
    {Prefix, [], []};
prefix([Ch1 | RestStr1], [Ch2 | RestStr2], Prefix) ->
    if
        Ch1 == Ch2 ->
            prefix(RestStr1, RestStr2, [Ch1 | Prefix]);
        true ->
            {Prefix, [Ch1 | RestStr1], [Ch2 | RestStr2]}
    end.

main() ->
    {ok, [Str1, Str2]} = io:fread("", "~s~s"),
    {PrefixStr, RestStr1, RestStr2} = prefix(Str1, Str2, []),
    io:format("~p ~s~n", [length(PrefixStr), lists:reverse(PrefixStr)]),
    io:format("~p ~s~n", [length(RestStr1), RestStr1]),
    io:format("~p ~s~n", [length(RestStr2), RestStr2]).
