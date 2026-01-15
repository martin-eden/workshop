-- 2-d gradient generator

--[[
  Author: Martin Eden
  Last mod.: 2026-01-14
]]

local t2s = request('!.table.as_string')

-- Exports:
return
  function(self)
    local Plan

    self:Init()
    -- print('Init():')
    -- print(t2s(self))

    Plan = self:CreateExecutionPlan()
    -- print('Plan:')
    -- print(t2s(Plan))

    self:ExecutePlan(Plan)

    -- print('Done:')
    -- print(t2s(self))
  end

--[[
  2025 # # # # # # # #
  2026-01-13
]]
