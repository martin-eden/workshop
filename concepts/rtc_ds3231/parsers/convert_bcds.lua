-- Parse BCD values.

local bcd_paths = request('bcd_paths')
local path_get_value = request('!.table.path_get_value')
local from_bcd = request('!.number.from_bcd')

return
  function(data)
    local result = data

    for _, path in ipairs(bcd_paths) do
      local node_bcd_name = path[#path]
      -- New name is same with stripped "_bcd" ending:
      local new_node_name = node_bcd_name:gsub('_bcd$', '')
      local node = path_get_value(result, path, -2)
      node[new_node_name] = from_bcd(node[node_bcd_name])
      -- Delete "_bcd" name:
      node[node_bcd_name] = nil
    end

    return result
  end
