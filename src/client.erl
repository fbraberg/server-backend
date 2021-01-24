-module (client).
-export ([start_client/1]).
-include ("../inc/client.hrl").

start_client(Name) ->
    spawn (fun() -> client_loop(#client{pid = self(), name = Name, status = active }) end).

client_loop(Client) ->
    receive
        {ReqType, Data}         -> spawn (fun() -> handle_req(ServerPid, State, ReqType, Data) end);
        _Undef                  -> spawn (fun() -> handle_err(_Undef) end)
    end,
    client_loop(Client).


send_request(ServerPid, Req, Data) ->
    ServerPid ! {Req, Data}.


% An error has occured
handle_err(Var) ->
    io:fwrite("Error!~n").
