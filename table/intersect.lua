-- Keep in table A only keys that are present in table B

--[[
  Author: Martin Eden
  Last mod.: 2026-09-22
]]

local Rules =
  {
    { has_a = true, has_b = false, action = 'remove' },
    { has_a = false, has_b = true, action = 'remove' },
  }

local apply_table = request('apply_table')

return
  function(A, B)
    apply_table(A, B, Rules)
  end

--[[
  2026-07-12
]]
