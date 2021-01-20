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
         {ReqType, Data} -> spawn (fun() -> handle_req(ServerPid, State, ReqType, Data) end);
         _Undef          -> spawn (fun() -> handle_err(_Undef) end)
     end,
     server_loop(State, ServerPid).

% A new state is to be taken
handle_req(ServerPid, State, stateChange, NewState) ->
     io:fwrite("StateChange!~n");

% A client wants to connect
handle_req(ServerPid, State, connect, Client) ->
    io:fwrite("Connect!~n"),
    case lists:member(Client, State#state.clients) of
        false -> ServerPid ! {stateChange, State#state.clients ++ [Client]}
    end;

% A client wants to disconnect
handle_req(ServerPid, State, disconnect, Client) ->
    io:fwrite("Disconnect!~n").

% An error has occured
handle_err(Var) ->
    io:fwrite("Error!~n").
