--[[
  Change BCD values to normal integers.

  Fields with BCD values are enlisted in [bcd_paths]. Name of every
  such field is assumed to end on "_bcd".

  We convert BCD to integer and write it to new field, with name
  without "_bcd" at end. Then we delete all processed BCD fields.
]]

local bcd_paths = request('^.data.bcd_paths')
local path_get_value = request('!.table.path_get_value')
local from_bcd = request('!.number.from_bcd')

return
  function(data)
    local result = data

    for _, path in ipairs(bcd_paths) do
      local node_bcd_name = path[#path]
      local new_node_name = node_bcd_name:gsub('_bcd$', '')
      local node = path_get_value(result, path, -2)
      node[new_node_name] = from_bcd(node[node_bcd_name])
      node[node_bcd_name] = nil
    end

    return result
  end
