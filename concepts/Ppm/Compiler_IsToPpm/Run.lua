-- Convert from .is to .ppm

-- Last mod.: 2024-11-06

-- Exports:
return
  --[[
    Gets list of strings/lists structure.
    Writes to output in .ppm format.

    When failed returns false.
  ]]
  function(self, PpmIs)
    local Label = self.Constants.FormatLabel

    self:WriteLabel(Label)

    local HeaderIs = PpmIs[1]
    self:WriteHeader(HeaderIs)

    local Header = self:ParseHeader(HeaderIs)

    if not Header then
      return false
    end

    local DataIs = PpmIs[2]
    self:WriteData(DataIs, Header)

    return true
  end

--[[
  2024-11-02
  2024-11-03
]]
