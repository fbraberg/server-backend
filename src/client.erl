-module (client).
-export ([start_client/1]).
-include ("../inc/client.hrl").

start_client(Name) ->
    spawn (fun() -> client_loop(#client{pid = self(), name = Name, status = active }) end).

client_loop(Client) -> client_loop(Client).
