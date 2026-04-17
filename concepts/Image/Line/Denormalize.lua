-- Map normalized image colors to byte range

-- Last mod.: 2026-04-17

-- Imports:
local DenormalizeColor = request('^.Color.Denormalize')
local ApplyFunc = request('!.concepts.list.apply_func')

local Denormalize =
  function(Line)
    return ApplyFunc(DenormalizeColor, Line)
  end

-- Exports:
return Denormalize

--[[
  2024-11-24
]]
