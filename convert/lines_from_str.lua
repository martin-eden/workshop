-- Convert string to lines

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local newline = request('!.concepts.ascii.chars').newline
local split_string = request('!.string.split')

return
  function(str)
    return split_string(str, newline)
  end

--[[
  2024 # # #
  2026 #
]]
