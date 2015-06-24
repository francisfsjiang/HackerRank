-module (solution).
-export ([main/0]).

check_around([], _, _) ->
    true;
check_around([{X, Y} | RestQueens], PosX, PosY) ->
    if
        (X == PosX) or (Y == PosY) or (abs(PosX - X) == abs(PosY - Y)) ->
            false;
        (abs(PosX - X) == 2) and (abs(PosY - Y) == 1) ->
            false;
        (abs(PosX - X) == 1) and (abs(PosY - Y) == 2) ->
            false;
        true ->
            check_around(RestQueens, PosX, PosY)
    end.

check_around([{PosX, PosY} | RestQueens]) ->
    check_around(RestQueens, PosX, PosY).


super_queen([], RowNumNow, _, MapSize) when RowNumNow > MapSize->
    {true, 0};
%success
super_queen(_, RowNumNow, _, MapSize) when RowNumNow > MapSize->
    {true, 1};

%this row failed
super_queen(_, _, ColumnNumNow, MapSize) when ColumnNumNow  > MapSize ->
    false;

%general test
super_queen(Queens, RowNumNow, ColumnNumNow, MapSize) ->
    NewQueen = {RowNumNow, ColumnNumNow},
    % io:format("-----~n~p~n~p~n", [NewQueen, Queens]),
    case check_around([NewQueen | Queens]) of
        false ->
            super_queen(Queens, RowNumNow, ColumnNumNow + 1, MapSize);
        true ->
            case super_queen([NewQueen | Queens], RowNumNow + 1, 1, MapSize) of
                {true, N} ->
                    case super_queen(Queens, RowNumNow, ColumnNumNow + 1, MapSize) of
                        {true, OtherN} ->
                            {true, N + OtherN};
                        false ->
                            {true, N}
                    end;
                false ->
                    super_queen(Queens, RowNumNow, ColumnNumNow + 1, MapSize)
            end
    end.


main() ->
    {ok, [N]} = io:fread("", "~d"),
    case super_queen([], 1, 1, N) of
        {true, Num} ->
            io:format("~p~n", [Num]);
        false ->
            io:format("0")
    end.
