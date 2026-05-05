-- Load file as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local file_as_str = request('!.file_system.file.as_string')

local load_str_from_file =
  function(file_name)
    return file_as_str(file_name)
  end

-- Export:
return load_str_from_file

--[[
  // similar code was at 201x's
  2026-04-27
]]
