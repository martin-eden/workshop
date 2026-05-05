--[[
  Change BCD values to normal integers.

  Fields with BCD values are listed in [bcd_fields_to_rename].
  For each field we convert it's value to integer and rename field.
]]

local bcd_fields_to_rename = request('^.data.bcd_fields_to_rename')
local rename_field = request('!.table.rename_field')
local path_get_value = request('!.table.path_get_value')
local path_set_value = request('!.table.path_set_value')
local bcd_to_byte = request('!.convert.bcd_to_byte')

return
  function(data)
    local result = data

    for _, rename_rec in ipairs(bcd_fields_to_rename) do
      rename_field(data, data, rename_rec.bcd, rename_rec.int)
      local new_node_val = path_get_value(data, rename_rec.int)
      new_node_val = bcd_to_byte(new_node_val)
      path_set_value(data, rename_rec.int, new_node_val)
    end

    return result
  end
