-- Generate linear gradient between two points

-- Last mod.: 2025-11-12

-- local t2s = request('!.table.as_string')

local Generate =
  function(self)
    local Plan = self:CreateExecutionPlan()

    -- print('Plan', t2s(Plan))

    for Index, Args in ipairs(Plan) do
      self:CreatePixel(Args[1], Args[2], Args[3])
      -- ^ or just "(table.unpack(Args))"
    end
  end

-- Exports:
return Generate

--[[
  2025-04-28
]]
