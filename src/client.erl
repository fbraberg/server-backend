-module (client).
-export ([start_client/1]).
-include ("../inc/client.hrl").

start_client(Name) ->
    Client = #client{pid = "", name = Name, status = "2"},
    spawn (fun() -> client_loop(Client) end).

client_loop(Client) -> client_loop(Client).
