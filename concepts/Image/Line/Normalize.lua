-- Normalize image colors that are in byte range

-- Last mod.: 2024-11-25

-- Imports:
local NormalizeColor = request('^.Color.NormalizeBytes')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local Normalize =
  function(Line)
    return ApplyFunc(NormalizeColor, Line.Colors)
  end

-- Exports:
return Normalize

--[[
  2024-11-24
]]
