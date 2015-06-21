-module(solution).
-export([main/0]).

gcd(A, 0) ->
    A;
gcd(A, B) when A < B ->
    gcd(B, A);
gcd(A, B) ->
    gcd(B, A rem B).

read_list(0) ->
    [];
read_list(N) ->
    {ok, [X]} = io:fread("", "~d"),
    [X | read_list(N - 1)].

jump([], LCM) ->
    LCM;
jump([Bunny | Bunnies], LCM) ->
    jump(Bunnies, Bunny * LCM div gcd(Bunny, LCM)).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    Bunnies = read_list(N),
    Result = jump(Bunnies, 1),
    io:format("~w~n", [Result]).
