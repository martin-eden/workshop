-- Linear 1-d generator

-- Last mod.: 2025-04-25

--[[
  Generate linear gradient between two points

  If no endline pixels are set, we'll set them to random colors.
]]
local Run =
  function(self)
    self:Init()

    local Plan = self:CreateExecutionPlan()

    for Index, Args in ipairs(Plan) do
      self:CreatePixel(Args[1], Args[2], Args[3])
      -- ^ or just "(table.unpack(Args))"
    end
  end

-- Exports:
return Run

--[[
  2025-04-05
  2025-04-15
  2025-04-23
  2025-04-25
]]
