-module(server).
-export([start_server/(1)]).

-record (state, {
                 clients = [],
                 max_clients ::integer()
                }).

-record (client, {
                  pid,
                  name,
                  status
                 }).

start_server(Max_clients) ->
    State = #state {clients = [], max_clients = Max_clients},
    spawn (fun() -> server_loop(State) end).


server_loop(State) ->
     io:format("~p~n", [State#state.max_clients]),
    server_loop(State).


% Client connects
connect(Client) ->
    0.
