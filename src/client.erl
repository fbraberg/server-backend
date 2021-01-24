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

% ========The following functions are for communicating with the server========
% Send request to server
send_request(ServerPid, Req, Data) ->
    ServerPid ! {Req, Data}.

% Attempt to connect to server
connect(ServerPid, ) -> 0.
% =============================================================================


% =======The following functions are for changing the local client state=======
% Change your activitity status
change_status() -> 0.

% Check with the server if name is available, THEN change it.
change_name() -> 0.
% =============================================================================

% An error has occured
handle_err(Var) ->
    io:fwrite("Error!~n").
