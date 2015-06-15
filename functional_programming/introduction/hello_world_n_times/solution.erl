-module(solution).
-export([main/0]).

print_n(N) when N > 0 ->
    io:format("Hello World~n"),
    print_n(N-1);
print_n(0) ->
    ok.

main() ->
    {ok, [N]} = io:fread("", "~d"),
    print_n(N).
