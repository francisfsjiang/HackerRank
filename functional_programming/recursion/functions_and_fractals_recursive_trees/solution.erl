-module(solution).
-export([main/0]).

iter_map(_, _, _, 63, 101) ->
    ok;
iter_map(F, FLineEnd, Table, M, 101) ->
    FLineEnd(),
    iter_map(F, FLineEnd, Table, M + 1, 1);
iter_map(F, FLineEnd, Table, M, N) ->
    F(Table, {M, N}),
    iter_map(F, FLineEnd, Table, M, N+1).

grow(_, TargetPosX, TargetPosX, _) ->
    ok;
grow(Table, PosX, TargetPosX, PosY) ->
    ets:insert(Table, {{PosX, PosY}, 1}),
    grow(Table, PosX - 1, TargetPosX, PosY).

grow_branch(_, TargetPosX, TargetPosX, _, _) ->
    ok;
grow_branch(Table, PosX, TargetPosX, PosY, Width) ->
    ets:insert(Table, {{PosX, PosY + Width}, 1}),
    ets:insert(Table, {{PosX, PosY - Width}, 1}),
    grow_branch(Table, PosX - 1, TargetPosX, PosY, Width + 1).

recutree(_, 0, _, _, _) ->
    ok;
recutree(Table, N, PosX, PosY, Height) ->
    HalfHeight = Height div 2,
    grow(       Table, PosX,          PosX - HalfHeight, PosY),
    grow_branch(Table, PosX - HalfHeight, PosX - Height, PosY, 1),
    recutree(Table, N-1, PosX - Height, PosY + HalfHeight, HalfHeight),
    recutree(Table, N-1, PosX - Height, PosY - HalfHeight, HalfHeight).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Table = ets:new(rtree, [set]),
    iter_map(fun(T, X) -> ets:insert(T, {X, 0}) end, fun() -> ok end, Table, 1, 1),
    recutree(Table, N, 63, 50, 32),
    iter_map(fun(T, Pos) ->
        [{_, X}|_] = ets:lookup(T, Pos),
        case X of
            0 -> io:format("_");
            _ -> io:format("1")
        end end, fun() -> io:format("~n") end, Table, 1, 1).
