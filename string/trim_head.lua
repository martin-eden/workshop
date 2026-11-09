-- Remove spaces at start of string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local str_sub = string.sub
local space = request('!.concepts.ascii.chars').space

return
  function(str)
    local read_pos = 1
    while (str_sub(str, read_pos, read_pos) == space) do
      read_pos = read_pos + 1
    end
    return str_sub(str, read_pos, #str)
  end

--[[
  2017 #
  2026-11-09
]]
