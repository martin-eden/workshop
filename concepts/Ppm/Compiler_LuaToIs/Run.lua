-- Anonymize parsed .ppm

-- Last mod.: 2024-11-24

--[[
  Compile Lua table to anonymous structure
]]
local Compile =
  function(self, Ppm)
    local HeaderIs = self:CompileHeader(Ppm)
    local DataIs = self:CompileData(Ppm)

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
