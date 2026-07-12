-- Replace contents of table

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

-- Imports:
local apply_table = request('apply_table')

local Rules =
  {
    { has_a = true, has_b = true, action = 'replace' },
    { has_a = false, has_b = true, action = 'replace' },
    { has_a = true, has_b = false, action = 'remove' },
  }

local replace_table =
  function(Dest, Src)
    apply_table(Dest, Src, Rules)
  end

-- Export:
return replace_table

--[[
  2018
  2026-07-12
]]
