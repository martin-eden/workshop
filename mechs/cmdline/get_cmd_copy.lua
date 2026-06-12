-- Return shell command to copy file to another name/location.

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local parse_pathname = request('!.concepts.path_name.parse')
local normalize = request('!.file_system.file.normalize_name')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

-- Export:
return
  function(src_name, dest_name)
    local src_file_name = parse_pathname(src_name).Name
    local dest_file_name = parse_pathname(dest_name).Name

    if (src_file_name == dest_file_name) then
      dest_name = parse_pathname(dest_name).HostDir
    end

    local Command =
      {
        'cp',
        quote(normalize(src_name)),
        quote(normalize(dest_name)),
      }

    return glue_words(Command)
  end

--[[
  2018 #
  2024 #
  2026-01 #
  2026-04 # #
  2026-06-12
]]
