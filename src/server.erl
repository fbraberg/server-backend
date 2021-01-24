
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

-module(server).
-export([start_server/(1)]).
-include("../inc/server.hrl").
-include("../inc/client.hrl").

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



% A new state is to be taken
handle_req(ServerPid, State, stateChange, NewState) ->
     io:fwrite("StateChange!~n");

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
