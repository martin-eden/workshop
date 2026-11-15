-- Return regexp string to match one of characters from list

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

local list_to_str = request('!.concepts.list.to_string')
local defuse = request('!.lua.regexp.quote')

return
  function(chars)
    return '[' .. defuse(list_to_str(chars)) .. ']'
  end

--[[
  2026-11-15
]]
