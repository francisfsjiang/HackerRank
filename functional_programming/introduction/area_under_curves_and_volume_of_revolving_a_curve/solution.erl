-module(solution).
-export([main/0]).

% print([]) ->
%     ok;
% print([A|B]) ->
%     io:format("~p~n",[A]),
%     print(B).

f([], [], _) ->
    0;
f([A| ArrA], [B| ArrB], X) ->
    A*math:pow(X,B) + f(ArrA, ArrB, X).


solve1(ArrA, ArrB, LimitS, LimitT) when LimitS =< LimitT ->
    f(ArrA, ArrB, LimitS) * 0.001 + solve1(ArrA, ArrB, LimitS+0.001, LimitT);
solve1(_, _, _, _) ->
    0.

solve2(ArrA, ArrB, LimitS, LimitT) when LimitS =< LimitT ->
    Radius = f(ArrA, ArrB, LimitS),
    Radius*Radius* math:pi() * 0.001 + solve2(ArrA, ArrB, LimitS+0.001, LimitT);
solve2(_, _, _, _) ->
    0.


read_list() ->
    case io:fread("", "~d") of
        {ok, [X]} ->
            [X | read_list()];
        eof ->
            []
    end.

split(A, []) ->
    [A];
split(A, [N| Next]) ->
    {B, Remain}= lists:split(N, A),
    [B | split(Remain, Next)].

main() ->
	INPUT = read_list(),
    Len = length(INPUT),
    [ArrA, ArrB, [LimitS], [LimitT] | _] = split(INPUT, [(Len-2) div 2, (Len-2) div 2, 1, 1]),
    Result1 = solve1(ArrA, ArrB, LimitS, LimitT),
    io:format("~.1f~n", [Result1]),
    Result2 = solve2(ArrA, ArrB, LimitS, LimitT),
    io:format("~.1f~n", [Result2]).
