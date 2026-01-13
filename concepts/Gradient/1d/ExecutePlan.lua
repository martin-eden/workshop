-- Execute 1-d segment generation plan

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

return
  function(self, Plan)
    -- Yeah I know here is ipairs() but somewhy here I prefer to write so
    for i = 1, #Plan do
      local Rec = Plan[i]
      local X, Left, Right = Rec[1], Rec[2], Rec[3]
      self:CreatePixel(X, Left, Right)
    end
  end

-- 2026-01-13
