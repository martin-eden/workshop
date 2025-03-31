-- Convert from .is to .ppm

-- Last mod.: 2025-03-28

--[[
  Receives list of strings/lists structure.
  Writes to <.Output> in .ppm format.

  Contract obliges us to return true at end.
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
