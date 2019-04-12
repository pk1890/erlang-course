%%%-------------------------------------------------------------------
%%% @author mleko
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. mar 2019 10:49
%%%-------------------------------------------------------------------
-module(qsort).
-author("mleko").

%% API
-export([lessThan/2, greatEqThan/2, qs/1, randomElems/3, compareSpeeds/3, mapp/2, filterr/2, mappp/2, sumList/1, fact/1]).

lessThan(Val, Arr) -> lists:filter(fun (X) -> X < Val end, Arr).
greatEqThan(Val, Arr) -> lists:filter(fun (X) -> X >= Val end, Arr).

qs([]) -> [];
qs([Pivot | Tail]) -> qs(lessThan(Pivot, Tail)) ++ [Pivot] ++ qs(greatEqThan(Pivot, Tail)).

randomElems(N, Min, Max) -> [rand:uniform(Max-Min+1)+Min-1 || _ <- lists:seq(1, N)].

compareSpeeds(List, Fun1, Fun2) when is_list(List)-> {timer:tc(Fun1, [List]), timer:tc(Fun2, [List])}.

mapp(_, []) -> [];
mapp(F, [H |T]) -> [F(H) | mapp(F, T)].

mappp(F, Arr) -> [F(X) || X <- Arr].

filterr(P, Arr) -> [X || X <- Arr, P(X)].

sumList(List) when is_list(List)-> lists:foldl(fun (X, Acc) -> X+Acc end, 0, List).

%%sumDigit(N) ->  lists:foldl(fun (X, Sum) ->  end, 0, integer_to_list(N)).


fact(0) -> 1;
fact(X) when is_integer(X) -> X*fact(X-1).