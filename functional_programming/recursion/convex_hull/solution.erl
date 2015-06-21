-module(solution).
-export([main/0]).

read_list(0) ->
    [];
read_list(N) ->
    {ok, [X, Y]} = io:fread("", "~d~d"),
    [{X, Y} | read_list(N - 1)].

multiply({X0, Y0}, {X1, Y1}, {X2, Y2}) ->
    (X1 - X0) * (Y2 - Y0) - (X2 - X0) * (Y1 - Y0).

distance({X0, Y0}, {X1, Y1}) ->
    math:sqrt((X1 - X0) * (X1 - X0) + (Y1 - Y0) * (Y1 - Y0)).

get_bottommost_leftmost([BasePoint | Points]) ->
    get_bottommost_leftmost(Points, BasePoint, []).

get_bottommost_leftmost([], TargetPoint, Others) ->
    {TargetPoint, Others};
get_bottommost_leftmost([Point|Rest], TargetPoint, Others) ->
    {X, Y} = Point,
    {TargetX, TargetY} = TargetPoint,
    if
        (Y < TargetY) or ((Y == TargetY) and (X < TargetX)) -> get_bottommost_leftmost(Rest, Point, [TargetPoint | Others]);
        true -> get_bottommost_leftmost(Rest, TargetPoint, [Point | Others])
    end.

recu([], Stack) ->
    Stack;
recu([Point | Rest], [Top, Top2 | Stack]) ->
    S = multiply(Point, Top, Top2),
    if
        S >= 0 ->
            recu([Point | Rest], [Top2 | Stack]);
        true ->
            recu(Rest, [Point, Top, Top2 | Stack])
    end;
recu([Point | Rest], [Top | Stack]) ->
    recu(Rest, [Point, Top | Stack]).

convex_hull(Points) ->
    {BasePoint, Others} = get_bottommost_leftmost(Points),
    [First | SortedOthers] = lists:sort(fun(A, B) ->
                    (multiply(B, A, BasePoint) < 0) or
                    ((multiply(B, A, BasePoint) == 0) and
                    (distance(BasePoint, B) > distance(BasePoint, A))) end,
                    Others
            ),
    recu(SortedOthers, [First, BasePoint]).

calc(Points) ->
    [First| _] = Points,
    calc(Points, First).

calc([A, B | C], First) ->
    distance(A, B) + calc([B|C], First);
calc([A], First) ->
    distance(A, First).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Points = read_list(N),
    % io:format("~w", [Points]),
    % io:format("~n"),
    ConvexHull = convex_hull(Points),
    % io:format("~w", [ConvexHull]),
    % io:format("~n"),
    Dist = calc(ConvexHull),
    io:format("~.1f", [Dist]).
