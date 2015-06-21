-module(solution).
-export([main/0]).

str_compress([Ch | Str]) ->
    str_compress(Str, Ch, 1).

str_compress([], LastCH, LastCount) ->
    if
        LastCount == 1 -> io:format("~c", [LastCH]);
        true -> io:format("~c~w", [LastCH, LastCount])
    end;
str_compress([CH | RestStr], LastCH, LastCount) ->
    if
        CH == LastCH -> str_compress(RestStr, LastCH, LastCount + 1);
        LastCount == 1 ->
            io:format("~c", [LastCH]),
            str_compress(RestStr, CH, 1);
        true ->
            io:format("~c~w", [LastCH,LastCount]),
            str_compress(RestStr, CH, 1)
    end.

main() ->
    {ok, [Str]} = io:fread("", "~s"),
    str_compress(Str).
