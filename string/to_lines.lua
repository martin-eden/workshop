-- Convert string to list of lines

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local split_string = request('!.string.split')

local lines_delimiter = '\n'

local string_to_lines =
  function(str)
    return split_string(str, lines_delimiter)
  end

-- Exports:
return string_to_lines

--[[
  2024 # # #
  2026-05-04
]]
