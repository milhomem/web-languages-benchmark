-module(erlang_Benchmark_controller, [Req]).
-compile(export_all).
index('PUT', []) ->
    {Struct, JsonRequest} = mochijson2:decode(Req:request_body()),
    Lat = proplists:get_value(<<"lat">>, JsonRequest),
    Long = proplists:get_value(<<"long">>, JsonRequest),
    {ok, Hash} = geohash:encode(Lat, Long, 16),
    NewPosition = positions:new("positions-556018800640fd52df330d31", Lat, Long, Hash),
    {ok, X} = NewPosition:save(),
    {204, []}.
