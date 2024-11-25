-- Convert from .is to .ppm

-- Last mod.: 2024-11-25

--[[
  Gets list of strings/lists structure. Writes in .ppm format.

  When failed returns false.
]]
local SerializePpm =
  function(self, PpmIs)
    local Label = self.Constants.FormatLabel
    local HeaderIs = PpmIs[1]
    local DataIs = PpmIs[2]

    self:WriteLabel(Label)
    self:WriteHeader(HeaderIs)
    self:WriteData(DataIs)

    return true
  end

-- Exports:
return SerializePpm

--[[
  2024-11-02
  2024-11-03
  2024-11-25
]]
