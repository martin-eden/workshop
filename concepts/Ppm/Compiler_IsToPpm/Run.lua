-- Convert from .is to .ppm

-- Last mod.: 2024-12-12

--[[
  Gets list of strings/lists structure. Writes in .ppm format.

  When failed returns false.
]]
local SerializePpm =
  function(self, PpmIs)
    self:WriteLabel()
    self:WriteHeader(PpmIs)
    self:WriteData(PpmIs)

    return true
  end

-- Exports:
return SerializePpm

--[[
  2024-11-02
  2024-11-03
  2024-11-25
  2024-12-12
]]
