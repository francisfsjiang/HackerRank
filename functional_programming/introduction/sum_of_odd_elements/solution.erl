-module(solution).
-export([main/0]).

read_list() ->
    case io:fread("", "~d") of
        {ok, [X]} ->
            [X | read_list()];
        eof ->
            []
    end.


main() ->
	L = read_list(),
    % L=[-1,-2,-3],
    SUM = lists:foldl(fun(X, Sum) ->
                            case (X+300) rem 2 of
                                1 -> X + Sum;
                                _ -> Sum
                            end end, 0, L),
    io:format("~w~n", [SUM]).
