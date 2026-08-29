-- Convert string to lines

--[[
  Author: Martin Eden
  Last mod.: 2026-08-29
]]

local newline = request('!.concepts.Ascii.Chars').newline
local split_string = request('!.string.split')

-- Export:
return
  function(str)
    return split_string(str, newline)
  end

--[[
  2024 # # #
  2026 #
]]
