-- Return list of children for given node

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

--[[
  Each record in list should have fields ".key" and ".value".

  This method is assumed to be overridden for custom formats.
]]

-- Imports:
local get_key_vals = request('!.table.get_key_vals')
local compare_keys = request('!.table.ordered_pass.compare_keys')

local get_children =
  function(self, node)
    local result = {}
    local key_vals = get_key_vals(node)
    local also_visit_keys = self.also_visit_keys
    for _, rec in ipairs(key_vals) do
      if is_table(rec.value) then
        result[#result + 1] = rec
      end
      if also_visit_keys and is_table(rec.key) then
        result[#result + 1] = {key = rec.key, value = rec.key}
      end
    end
    table.sort(result, compare_keys)
    return result
  end

return get_children

--[[
  2017-09-13
]]
