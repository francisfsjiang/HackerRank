-module (solution).
-export ([main/0]).


dp(Arr, M, Index, N) ->
    Power = trunc(math:pow(N, 1 / Index)),
    dp(Arr, M, Index, Power, trunc(math:pow(Power, Index)), N).


dp(Arr, _, _, 0, _, _) ->
    Arr;
dp(Arr, M, Index, Power, N, IterM) when N == (IterM + 1) ->
    NewN = trunc(math:pow(Power - 1, Index)),
    dp(Arr, M, Index, Power - 1, NewN, M);
dp(Arr, M, Index, Power, N, IterM) ->
    % io:format("~p~n", [array:to_list(Arr)]),
    % io:format("~p ~p ~p ~p ~p~n", [M, Index, Power, N, IterM]),
    Pre = array:get(IterM - N ,Arr),
    Now = array:get(IterM, Arr),
    % io:format("~p ~p~n", [Pre, Now]),
    NewArr = array:set(IterM, Now + Pre, Arr),
    dp(NewArr, M, Index, Power, N, IterM - 1).



main() ->
    {ok, [M, Index]} = io:fread("", "~d~d"),
    Arr = array:new([{size, M + 1}, {fixed, false}, {default, 0}]),
    NewArr = dp(array:set(0, 1, Arr), M, Index, M),
    R = array:get(M, NewArr),
    io:format("~p~n", [R]).
