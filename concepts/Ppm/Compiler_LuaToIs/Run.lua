-- Anonymize parsed .ppm

-- Last mod.: 2024-11-25

--[[
  Compile Lua table to anonymous structure
]]
local Compile =
  function(self, Image)
    local HeaderIs = self:CompileHeader(Image)
    local DataIs = self:CompileImage(Image)

    if not (HeaderIs and DataIs) then
      return
    end

    return { HeaderIs, DataIs }
  end

-- Exports:
return Compile

--[[
  2024-11-03
  2024-11-06
]]
