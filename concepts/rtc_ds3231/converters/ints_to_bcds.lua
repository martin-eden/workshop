--[[
  Change integers to BCD values.

  Fields with BCD values are listed in [bcd_fields_to_rename].
  For each field we convert it to BCD and rename field.
]]

local bcd_fields_to_rename = request('^.data.bcd_fields_to_rename')
local rename_field = request('!.table.rename_field')
local path_get_value = request('!.table.path_get_value')
local path_set_value = request('!.table.path_set_value')
local to_bcd = request('!.number.to_bcd')

return
  function(data)
    local result = data

    for _, rename_rec in ipairs(bcd_fields_to_rename) do
      rename_field(data, data, rename_rec.int, rename_rec.bcd)
      local new_node_val = path_get_value(data, rename_rec.bcd)
      new_node_val = to_bcd(new_node_val)
      path_set_value(data, rename_rec.bcd, new_node_val)
    end

    return result
  end
