-- Map normalized color components to byte range

-- Last mod.: 2026-04-17

-- Imports:
local DenormalizeLine = request('^.Line.Denormalize')
local ApplyFunc = request('!.concepts.list.apply_func')

local Denormalize =
  function(Image)
    return ApplyFunc(DenormalizeLine, Image)
  end

-- Exports:
return Denormalize

--[[
  2024-11-25
]]
