-module(solution).
-export([main/0]).

make_map(Map, 0) ->
    Str = "++++++++++",
    NewMap = parse_row(Map, 0, 0, [43 | Str]),
    make_map(NewMap, 1);
make_map(Map, 11) ->
    Str = "++++++++++",
    parse_row(Map, 11, 0, [43 | Str]);
make_map(Map, M) ->
    {ok, [Str]} = io:fread("", "~s"),
    NewMap = parse_row(Map, M, 0, [43 | Str]),
    make_map(NewMap, M + 1).

parse_row(Map, M, N, []) ->
    maps:put({M, N}, 43, Map);
parse_row(Map, M, N, [CH|Str]) ->
    NewMap = maps:put({M, N}, CH, Map),
    parse_row(NewMap, M, N + 1, Str).

display(_, 11, 12) ->
    io:format("~n"),
    ok;
display(Map, M, 12) ->
    io:format("~n"),
    display(Map, M + 1, 0);
display(Map, M, N) ->
    io:format("~c", [maps:get({M, N}, Map)]),
    display(Map, M, N + 1).

count_blank(Map, M, N, Direction) ->
    io:format("~p,~p~n~p~n", [M, N, Direction]),
    {DirX, DirY} = Direction,
    Next = maps:get({M + DirX, N + DirY}, Map),
    if
         ($- == Next) ->
            1 + count_blank(Map, M + DirX, N + DirY, Direction);
        true ->
            1
    end.

find_blanksL(_, 10, 11, Blanks) ->
    Blanks;
find_blanksL(Map, M, 11, Blanks) ->
    find_blanksL(Map, M + 1, 1, Blanks);
find_blanksL(Map, M, N, Blanks) ->
    Now = maps:get({M, N}, Map),
    LeftOne = maps:get({M, N - 1}, Map),
    RightOne = maps:get({M, N + 1}, Map),
    if
        (Now == $-) and (LeftOne == $+) and (RightOne == $-) ->
            NewBlanks = [{{M, N}, {0, 1}, count_blank(Map, M, N, {0, 1})} | Blanks],
            find_blanksL(Map, M, N + 1, NewBlanks);
        true ->
            find_blanksL(Map, M, N + 1, Blanks)
    end.

find_blanksU(_, 10, 11, Blanks) ->
    Blanks;
find_blanksU(Map, M, 11, Blanks) ->
    find_blanksU(Map, M + 1, 1, Blanks);
find_blanksU(Map, M, N, Blanks) ->
    Now = maps:get({M, N}, Map),
    UpOne = maps:get({M - 1, N}, Map),
    DownOne = maps:get({M + 1, N}, Map),
    if
        (Now == $-) and (UpOne == $+) and (DownOne == $-) ->
            NewBlanks = [{{M, N}, {1, 0}, count_blank(Map, M, N, {1, 0})} | Blanks],
            find_blanksU(Map, M, N + 1, NewBlanks);
        true ->
            find_blanksU(Map, M, N + 1, Blanks)
    end.

read_words() ->
    {ok, [OriginStr]} = io:fread("","~s"),
    StrList = string:tokens(OriginStr, ";"),
    lists:sort(fun({A, _}, {B, _}) -> A < B end,
               lists:map(fun(X) -> {length(X), X} end, StrList)).

try_fill_blanks(Map, {{_, _}, {_, _}, 0}, _) ->
    {true, Map};
try_fill_blanks(Map, {{PosX, PosY}, {DirX, DirY}, Len}, [Ch | RestWords]) ->
    OriginCh  = maps:get({PosX, PosY}, Map),
    io:format("~p,~p,~p~n", [OriginCh, Ch, Len]),
    if
        (OriginCh == $-) or (OriginCh == Ch) ->
            NewMap = maps:put({PosX, PosY}, Ch, Map),
            try_fill_blanks(NewMap, {{PosX + DirX, PosY + DirY}, {DirX, DirY}, Len - 1}, RestWords);
        true ->
            {false, Map}
    end.


fill_blanks(Map, [], _, _) ->
    {true, Map};
fill_blanks(Map, [_ | _], _, []) ->
    {false, Map};
fill_blanks(Map, [Blank | RestBlanks], WordsList, [WordNow | RestWords]) ->
    io:format("~p~n", [Blank]),
    io:format("~p~n", [WordNow]),
    display(Map, 0, 0),
    {{_, _}, {_, _}, Len} = Blank,
    {WordLen, Word} = WordNow,
    if
        Len > WordLen ->
            fill_blanks(Map, [Blank | RestBlanks], WordsList, RestWords);
        Len == WordLen ->
            case try_fill_blanks(Map, Blank, Word) of
                {true, NewMap} ->
                    case fill_blanks(NewMap, RestBlanks, WordsList, WordsList) of
                        {true, ResultMap} ->
                            ResultMap;
                        {false, Map} ->
                            fill_blanks(Map, [Blank | RestBlanks], WordsList, RestWords)
                    end;
                {false, _} ->
                    fill_blanks(Map, [Blank | RestBlanks], WordsList, RestWords)
            end;
        Len < WordLen ->
            {false, Map}
    end.

main() ->
    Map = make_map(maps:new(), 0),
    display(Map, 0, 0),
    Blanks = lists:sort(fun({_, _, A}, {_, _, B}) -> A < B end,
                        find_blanksL(Map, 1, 1, []) ++ find_blanksU(Map, 1, 1, [])),
    io:format("~p~n", [Blanks]),
    StrList = read_words(),
    io:format("~p~n", [StrList]),
    fill_blanks(Map, Blanks, StrList, StrList).
