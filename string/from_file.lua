-- Load file as string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

-- Imports:
local normalize_file_name = request('!.file_system.file.normalize_name')
local file_as_str = request('!.file_system.file.as_string')

-- Open given filename and load contents as string
local load_str_from_file =
  function(file_name)
    return file_as_str(normalize_file_name(file_name))
  end

-- Export:
return load_str_from_file

--[[
  // similar code was at 201x's
  2026-04-27
]]
