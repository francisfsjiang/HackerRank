-module(solution).
-export([main/0]).

str_compress([Ch | Str]) ->
    str_compress(Str, Ch, 1, []).

str_compress([], LastCH, LastCount, CompressedStr) ->
    if
        LastCount == 1 -> CompressedStr ++ [LastCH];
        true -> CompressedStr ++ [LastCH] ++ integer_to_list(LastCount)
    end;
str_compress([CH | RestStr], LastCH, LastCount, CompressedStr) ->
    if
        CH == LastCH -> str_compress(RestStr, LastCH, LastCount + 1, CompressedStr);
        LastCount == 1 ->
            str_compress(RestStr,
                                 CH,
                                 1,
                                 CompressedStr ++ [LastCH]);
        true -> str_compress(RestStr,
                             CH,
                             1,
                             CompressedStr ++ [LastCH] ++ integer_to_list(LastCount))
    end.

main() ->
    {ok, [Str]} = io:fread("", "~s"),
    Compressed = str_compress(Str),
    io:format("~s", [Compressed]).
