-- Represent words as string

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

-- Imports:
local list_to_string = request('!.concepts.list.to_string')

local to_string =
  function(Words)
    return list_to_string(Words, ' ')
  end

-- Export:
return to_string

--[[
  2026-04-15
]]
