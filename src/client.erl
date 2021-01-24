
% A simple server backend written in erlang.
% Copyright (C) 2021  Felix Bråberg
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.


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
