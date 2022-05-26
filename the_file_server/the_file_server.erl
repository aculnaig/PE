-module(the_file_server).
-export([start/1, loop/1]).

start(Dir) -> spawn(the_file_server, loop, [Dir]).

loop(Dir) ->
    receive
        {Client, list_dir} ->
            Client ! {self(), file:list_dir(Dir)};
        {Client, {get_file, File}} ->
            Full = filename:join(Dir, File),
            Client ! {self(), file:read_file(Full)};
        {Client, {put_file, FileName, FileContent}} ->
            Content = file:write_file(FileName, FileContent),
            Client ! {self(), Content}
    end,
    loop(Dir).
