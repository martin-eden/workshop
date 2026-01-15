-- Implement data space filling plan

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

return
  function(self, Plan)
    for i = 1, #Plan do
      local Rec = Plan[i]
      local NewPixel, NeibA, NeibB = Rec[1], Rec[2], Rec[3]
      self:CreatePixel(NewPixel, NeibA, NeibB)
    end
  end

--[[
  2026-01-13
  2026-01-14
]]
