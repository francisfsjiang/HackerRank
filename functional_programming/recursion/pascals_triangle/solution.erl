-module(solution).
-export([main/0]).

print([]) ->
    ok;
print([A|B]) ->
    io:format("~w ", [A]),
    print(B).

generate(A) ->
    generate(A, [1]).


generate([A, B|C], T) ->
    generate([B|C], T ++ [A+B]);
generate(_, T) ->
    T ++ [1].

pasc(0, _) ->
    ok;
pasc(N, A) ->
    print(A),
    io:format("~n"),
    B = generate(A),
    pasc(N-1, B).

main() ->
    {ok, [N]} = io:fread("", "~d"),
    pasc(N, [1]).
