--[[
  Return list of children for given node.

  Each record in list should have fields <key> and <value>.
  <key> - key to get <value>.

  This method assumed to be overriden for custom formats.
]]

local to_key_vals = request('!.table.to_key_val')
local compare = request('!.table.ordered_pass.default_comparator')

return
  function(self, node)
    local result = {}
    local key_vals = to_key_vals(node)
    local also_visit_keys = self.also_visit_keys
    for _, rec in ipairs(key_vals) do
      if is_table(rec.value) then
        result[#result + 1] = rec
      end
      if also_visit_keys and is_table(rec.key) then
        result[#result + 1] = {key = rec.key, value = rec.key}
      end
    end
    table.sort(result, compare)
    return result
  end
