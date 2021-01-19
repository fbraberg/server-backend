-module(server).
-export([start_server/(1)]).

-record (state, {
                 client_pids = [],
                 max_clients ::integer()
                }).

start_server(Max_clients) ->
    State = #state {client_pids = [], max_clients = Max_clients},
    spawn (fun() -> server_loop(State) end).

server_loop(State) ->
     io:format("~p~n", [State#state.max_clients]),
    server_loop(State).
