-module(the_file_client).
-export([ls/1, get_file/2, put_file/3]).

ls(Server) ->
    Server ! {self(), list_dir},
    receive
        {Server, FileList} ->
            FileList
    end.

get_file(Server, File) ->
    Server ! {self(), {get_file, File}},
    receive
        {Server, Content} ->
            Content
    end.

put_file(Server, FileName, FileContent) ->
    Server ! {self(), {put_file, FileName, FileContent}},
    receive
        {Server, Content} ->
            Content
    end.
