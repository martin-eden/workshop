-- From table A remove keys that are present in table B

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

local rule = { true, true, 'remove' }
local apply_table = request('apply_table')

return
  function(a, b)
    apply_table(a, b, rule)
  end

--[[
  2018 #
  2026 #
]]
