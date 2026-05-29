-- Convert string to lines

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local split_string = request('!.string.split')

local string_to_lines =
  function(str)
    local newline = '\n'

    return split_string(str, newline)
  end

-- Exports:
return string_to_lines

--[[
  2024 # # #
  2026-05-04
]]
