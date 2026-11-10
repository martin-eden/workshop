-- Replace contents of table

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

-- May produce wrong result if replacement contains links to origin

local rules =
  {
    { has_a = true, has_b = true, action = 'replace' },
    { has_a = false, has_b = true, action = 'replace' },
    { has_a = true, has_b = false, action = 'remove' },
  }

local apply_table = request('apply_table')

return
  function(origin, replacement)
    apply_table(origin, replacement, rules)
  end

--[[
  2018 #
  2026 #
]]
