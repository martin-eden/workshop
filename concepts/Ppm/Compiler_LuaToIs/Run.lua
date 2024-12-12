-- Anonymize parsed .ppm

-- Last mod.: 2024-12-12

--[[
  Compile Lua table to anonymous structure
]]
local Compile =
  function(self, Image)
    return self:CompileImage(Image)
  end

-- Exports:
return Compile

--[[
  2024-11-03
  2024-11-06
  2024-12-12
]]
