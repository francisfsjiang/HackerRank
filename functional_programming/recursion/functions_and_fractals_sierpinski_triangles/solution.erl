-module(solution).
-export([main/0]).

make_map(_, 32, 64) ->
    ok;
make_map(Table, M, 64) ->
    make_map(Table, M + 1, 1);
make_map(Table, M, N) ->
    case (N < 32 + M) and (N > 32 - M) of
        true -> ets:insert(Table, {{M, N}, 1});
        _ -> ets:insert(Table, {{M, N}, 0})
    end,
    make_map(Table, M, N+1).

display(_, 32, 64) ->
    ok;
display(Table, M, 64) ->
    io:format("~n"),
    display(Table, M + 1, 1);
display(Table, M, N) ->
    [{_, X}|_] = ets:lookup(Table, {M, N}),
    case X of
        0 -> io:format("_");
        _ -> io:format("1")
    end,
    display(Table, M, N+1).

clear_row(_, _, T, T) ->
    ok;
clear_row(Table, RowNum, S, T) ->
    ets:insert(Table, {{RowNum, S}, 0}),
    clear_row(Table, RowNum, S + 1, T).

clear_rows(_, RowNum, RowNum, _, _) ->
    ok;
clear_rows(Table, RowNum, BottomRowNum, S, T) ->
    clear_row(Table, RowNum, S, T),
    clear_rows(Table, RowNum + 1, BottomRowNum, S + 1, T - 1).

sler(_, 0, _, _, _) ->
    ok;
sler(Table, N, Row, Pos, Height) ->
    HalfHeight = Height div 2,
    clear_rows(Table, Row + HalfHeight, Row + Height, Pos - HalfHeight + 1, Pos + HalfHeight),

    sler(Table, N-1, Row, Pos, HalfHeight),
    sler(Table, N-1, Row + HalfHeight, Pos - HalfHeight, HalfHeight),
    sler(Table, N-1, Row + HalfHeight, Pos + HalfHeight, HalfHeight).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Table = ets:new(sler, [set]),
    make_map(Table, 1, 1),
    sler(Table, N, 1, 32, 32),
    display(Table, 1, 1).
