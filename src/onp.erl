
%%%-------------------------------------------------------------------
%%% @author kotara
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. Mar 2019 10:48 AM
%%%-------------------------------------------------------------------
-module(onp).
-author("kotara").

%% API
-export([onp/1, sToNo/1]).
%%
%%calc(Val1, Val2, Op) ->
%%  case Val2 of
%%     "sqrt" -> [float_to_list(math:sqrt(list_to_float(Val1))) | [Op]];
%%     "sin" -> [float_to_list(math:sin(list_to_float(Val1))) | [Op] ];
%%     "cos" -> [float_to_list(math:cos(list_to_float(Val1))) | [Op] ];
%%     "tan" -> [[float_to_list(math:tan(list_to_float(Val1)))] | [Op] ];
%%      _ ->
%%        IntVal1 = list_to_float(Val1),
%%        IntVal2 = list_to_float(Val2),
%%
%%        case Op of
%%          "+" -> float_to_list(IntVal1 + IntVal2);
%%          "-" -> float_to_list(IntVal1 - IntVal2);
%%          "*" -> float_to_list(IntVal1 * IntVal2);
%%          "/" -> float_to_list(IntVal1 / IntVal2)
%%
%%        end
%%
%%  end.
%%
%%
%%calcOnp([Val]) -> list_to_float(Val);
%%calcOnp([Val1, Val2]) -> calcOnp(calc(Val1, Val2, "0") ++ [$+]);
%%calcOnp([Val1, Val2, Op | T]) -> calcOnp([(calc(Val1, Val2, Op)) | T]).
%%
%%onp(Str) -> calcOnp(string:tokens(Str, " ")).


sToNo(Str) -> conv({string:to_float(Str), Str}).

conv({{A, []}, Str}) -> A;
conv({{A, _}, Str}) -> list_to_integer(Str).
%%
onp(Str) -> onp(string:tokens(Str, " "), []).

onp(["+" | T], [A, B | Op]) -> onp(T, [ B+A |Op]);
onp(["-" | T], [A, B | Op]) -> onp(T, [ B-A |Op]);
onp(["*" | T], [A, B | Op]) -> onp(T, [ B*A |Op]);
onp(["/" | T], [A, B | Op]) -> onp(T, [ B/A |Op]);
onp(["pow" | T], [A, B | Op]) -> onp(T, [ math:pow(B, A) |Op]);
onp(["sqrt" | T], [A | Op]) -> onp(T, [ math:sqrt(A) |Op]);
onp(["sin" | T], [A | Op]) -> onp(T, [ math:sin(A) |Op]);
onp(["cos" | T], [A | Op]) -> onp(T, [ math:cos(A) |Op]);
onp(["tan" | T], [A | Op]) -> onp(T, [ math:tan(A) |Op]);
onp(["sinh" | T], [A | Op]) -> onp(T, [ math:sinh(A) |Op]);
onp(["cosh" | T], [A | Op]) -> onp(T, [ math:cosh(A) |Op]);
onp(["tanh" | T], [A | Op]) -> onp(T, [ math:tanh(A) |Op]);
onp(["asin" | T], [A | Op]) -> onp(T, [ math:asin(A) |Op]);
onp(["acos" | T], [A | Op]) -> onp(T, [ math:acos(A) |Op]);
onp(["atan" | T], [A | Op]) -> onp(T, [ math:atan(A) |Op]);
onp(["asinh" | T], [A | Op]) -> onp(T, [ math:asinh(A) |Op]);
onp(["acosh" | T], [A | Op]) -> onp(T, [ math:acosh(A) |Op]);
onp(["atanh" | T], [A | Op]) -> onp(T, [ math:atanh(A) |Op]);
onp(["ln" | T], [A | Op]) -> onp(T, [ math:log(A) |Op]);
onp(["pi" | T], Op) -> onp(T, [math:pi() | Op]);
onp(["e" | T], Op) -> onp(T, [math:exp(1) | Op]);
onp([A | T], Op) -> onp(T, [sToNo(A) | Op]);
onp([], [A]) -> A.