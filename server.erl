-module(server).
-export([start_server/(1)]).

-record (state, {
                 clients = [],
                 max_clients
                }).

-record (client, {
                  pid,
                  name,
                  status
                 }).

start_server(Max_clients) ->
    State = #state {clients = [], max_clients = Max_clients},
    spawn (fun() -> server_loop(State, self()) end).


server_loop(State, ServerPid) ->
    receive
        {stateChange, NewState} -> server_loop(NewState, ServerPid);
        {ReqType, Data}         -> spawn (fun() -> handle_req(ServerPid, State, ReqType, Data) end);
        _Undef                  -> spawn (fun() -> handle_err(_Undef) end)
    end,
    server_loop(State, ServerPid).

% A client wants to connect
handle_req(ServerPid, State, connect, Client) ->
    C = State#state.clients,
    case lists:member(Client, State#state.clients) of
        false -> ServerPid ! {stateChange, State#state{clients = [Client|C]}}
    end;

% A client wants to disconnect
handle_req(ServerPid, State, disconnect, Client) -> 0.

% An error has occured
handle_err(Var) -> 0.
