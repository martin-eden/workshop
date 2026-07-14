-- Return shell command to copy file to another name/location.

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local pathname_from_str = request('!.concepts.path_name.pathname_from_str')
local get_file_name = request('!.concepts.path_name.get_name')
local get_host_dir = request('!.concepts.path_name.get_host_dir')
local normalize = request('!.concepts.path_name.normalize')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

local get_cmd_copy =
  function(src_pathname, dest_pathname)
    --[[
      Implementation smartness details:

        When called to copy file to same name but in another directory
        ( call like ( one_dir/file_a another_dir/file_a ) ) --
        file name is not mentioned in destination
        ( returned command is like "cp one_dir/file_a another_dir/" )
    ]]

    local src_filename = get_file_name(pathname_from_str(src_pathname))

    local DestPathname = pathname_from_str(dest_pathname)
    local dest_filename = get_file_name(DestPathname)

    if (src_filename == dest_filename) then
      dest_pathname = get_host_dir(DestPathname)
    end

    local Command =
      {
        'cp',
        quote(normalize(src_pathname)),
        quote(normalize(dest_pathname)),
      }

    return glue_words(Command)
  end

-- Export:
return get_cmd_copy

--[[
  2018 #
  2024 #
  2026-01 #
  2026-04 # #
  2026-06-12
]]
