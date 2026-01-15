-- N-dim space filling

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

-- Exports:
return
  function(self, PointA, PointAColor, PointB, PointBColor)
    do
      local Image = self.Image
      Image:SetPixel(PointA, PointAColor)
      Image:SetPixel(PointB, PointBColor)
    end

    local Plan = self:CreateExecutionPlan(PointA, PointB)

    self:ExecutePlan(Plan)
  end

-- 2026-01-14
