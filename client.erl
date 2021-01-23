-module (client).
-export ([start_client/1]).
-include ("client.hrl").

start_client(Name) ->
    #client{pid = "", name = Name, status = "2"},
    0.
