-- Load file as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local file_as_str = request('!.file_system.file.as_string')

local file_from_str =
  function(file_name)
    return file_as_str(file_name)
  end

-- Export:
return file_from_str

--[[
  // similar code was at 201x's
  2026-04-27
]]
