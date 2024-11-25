-- Map normalized color components to byte range

-- Last mod.: 2024-11-25

-- Imports:
local DenormalizeLine = request('^.1-d image.Denormalize')
local ApplyFunc = request('!.concepts.List.ApplyFunc')

local Denormalize =
  function(Image)
    return ApplyFunc(DenormalizeLine, Image.Lines)
  end

-- Exports:
return Denormalize

--[[
  2024-11-25
]]
