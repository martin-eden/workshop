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
  function(src_name, dest_name)
    local src_file_name = get_file_name(pathname_from_str(src_name))

    local DestPathname = pathname_from_str(dest_name)
    local dest_file_name = get_file_name(DestPathname)

    if (src_file_name == dest_file_name) then
      dest_name = get_host_dir(DestPathname)
    end

    local Command =
      {
        'cp',
        quote(normalize(src_name)),
        quote(normalize(dest_name)),
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
