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
     receive
         {ReqType, Data} -> spawn (fun() -> handle_req(self(), ReqType, Data) end);
         Undef           -> spawn (fun() -> handle_err(Undef) end)
     end,
     server_loop(State).

% A new state is to be taken
 handle_req(ParentPid, stateChange, NewState) ->

     io:fwrite("StateChange!~n");

% A client wants to connect
handle_req(ParentPid, connect, Client) ->
    io:fwrite("Connect!~n");

% A client wants to disconnect
handle_req(ParentPid, disconnect, Client) ->
    io:fwrite("Disconnect!~n").

% An error has occured
handle_err(Var) ->
    io:fwrite("Error!~n").
