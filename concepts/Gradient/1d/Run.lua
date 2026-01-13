-- Linear 1-d generator

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

-- local t2s = request('!.table.as_string')

return
  function(self)
    local Plan

    self:Init()
    Plan = self:CreateExecutionPlan()
    -- print('Plan', t2s(Plan))
    self:ExecutePlan(Plan)
  end

--[[
  2025 # # # # #
  2026-01-13
]]
