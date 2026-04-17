-- Normalize image colors that are in byte range

-- Last mod.: 2026-04-17

-- Imports:
local NormalizeColor = request('^.Color.Normalize')
local ApplyFunc = request('!.concepts.list.apply_func')

local Normalize =
  function(Line)
    return ApplyFunc(NormalizeColor, Line)
  end

-- Exports:
return Normalize

--[[
  2024-11-24
]]
