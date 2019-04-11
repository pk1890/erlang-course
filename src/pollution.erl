%%%-------------------------------------------------------------------
%%% @author mleko
%%% @copyright (C) 2019, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. kwi 2019 23:55
%%%-------------------------------------------------------------------
-module(pollution).
-author("mleko").

%% API
-export([addStation/3, createMonitor/0, isCoordUsed/2, getStation/2, addValue/5, removeValue/4, getOneValue/4, getStationMean/3]).



createMonitor() -> #{}.

cmpCoord({Lat1, Lon1}, {Lat2, Lon2}) -> Lat1 == Lat2 andalso Lon1 == Lon2.

addStation(Name, Coord, Monitor) ->
  case maps:is_key(Name, Monitor) of
     false ->  case isCoordUsed(Coord, Monitor) of
                 false -> Monitor, maps:put(Name, newStation(Name, Coord), Monitor);
                 _ -> throw("Station with given coords already exists")
               end;
     _ -> throw("Station already exists!")
  end.


newStation(Name, Coord) ->
  #{name => Name, coord => Coord, measurements => #{}}.

isCoordUsed(Coord, Monitor) ->
  lists:foldl(fun (X, Acc) -> Acc orelse X end,
    false,
    lists:map(fun (Elem) -> cmpCoord(maps:get(coord, Elem), Coord) end, maps:values(Monitor))).

getStation({Lat, Lon}, Monitor) -> maps:fold(fun (K, V, Acc) ->
                                                case cmpCoord(maps:get(coord, V), {Lat, Lon}) of
                                                  true -> V;
                                                  _ -> Acc
                                                end
                                             end, "NULL", Monitor);
getStation(Name, Monitor) -> maps:get(Name, Monitor).

%%addValue/5 - dodaje odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru, wartość), zwraca zaktualizowany monitor;


addValue(StationData, Date, Type, Val, Monitor) ->
  Station = getStation(StationData, Monitor),
  case maps:is_key({Date, Type}, maps:get(measurements, Station)) of
      true -> throw("Record with given data already exists in station");
      _ -> maps:update(maps:get(name, Station), maps:update(measurements, maps:put({Date, Type}, Val, maps:get(measurements, Station)), Station), Monitor)
end.


%%removeValue/4 - usuwa odczyt ze stacji (współrzędne geograficzne lub nazwa stacji, data, typ pomiaru), zwraca zaktualizowany monitor;

removeValue(StationData, Date, Type, Monitor) ->
  Station = getStation(StationData, Monitor),
  maps:update(maps:get(name, Station), maps:update(measurements, maps:remove({Date, Type}, maps:get(measurements, Station)), Station), Monitor).


%%getOneValue/4 - zwraca wartość pomiaru o zadanym typie, z zadanej daty i stacji;

getOneValue(Date, Type, StationData, Monitor) ->
  Station = getStation(StationData, Monitor),
  maps:get({Date, Type}, maps:get(measurements, Station)).

%%getStationMean/3 - zwraca średnią wartość parametru danego typu z zadanej stacji;

getStationMean(Type, StationData, Monitor) ->
  Station = getStation(StationData, Monitor),
  Vals = maps:values(maps:filter(fun ({_D, T}, _V) -> T == Type end, maps:get(measurements, Station))),
  lists:sum(Vals) / length(Vals).

%%getDailyMean/3 - zwraca średnią wartość parametru danego typu, danego dnia na wszystkich stacjach;

