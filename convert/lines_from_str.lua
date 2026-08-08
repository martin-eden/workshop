-- Convert string to lines

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

local split_string
local newline
do
  split_string = request('!.string.split')
  local AsciiChars = request('!.concepts.Ascii.Chars')
  newline = AsciiChars.newline
end

local string_to_lines =
  function(str)
    return split_string(str, newline)
  end

-- Exports:
return string_to_lines

--[[
  2024 # # #
  2026-05-04
]]
