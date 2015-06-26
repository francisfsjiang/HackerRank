-module (solution).
-export ([main/0]).


squ_check([], RNum, GNum, YNum, BNum) ->
    if
        (abs(RNum - GNum) > 1) and (abs(YNum - BNum) > 1) ->
            false;
        true ->
            {true, RNum, GNum, YNum, BNum}
    end;
squ_check([Ch | RestStr], RNum, GNum, YNum, BNum) ->
    % io:format("~p~n", [abs(RNum - GNum) > 1]),
    if
        (abs(RNum - GNum) > 1) and (abs(YNum - BNum) > 1) ->
            false;

        true ->
            case Ch of
                $R ->
                    squ_check(RestStr, RNum + 1, GNum, YNum, BNum);
                $G ->
                    squ_check(RestStr, RNum, GNum + 1, YNum, BNum);
                $Y ->
                    squ_check(RestStr, RNum, GNum, YNum + 1, BNum);
                $B ->
                    squ_check(RestStr, RNum, GNum, YNum, BNum + 1);
                _ ->
                    false
            end
    end.


full_color(0) ->
    ok;
full_color(T) ->
    {ok, [Str]} = io:fread("", "~s"),
    case squ_check(Str, 0, 0, 0, 0) of
        {true, RNum, GNum, YNum, BNum} ->
            if
                (RNum == GNum) and (YNum == BNum) ->
                    io:format("True~n");
                true ->
                    io:format("False~n")
            end;
        false ->
            io:format("False~n")
    end,
    full_color(T - 1).

main() ->
    {ok, [T]} = io:fread("", "~d"),
    full_color(T).
