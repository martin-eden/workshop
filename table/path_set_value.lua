--[[
  Receive start node (table), array with path to node and
  new node value.

  Traverse path and set final node to given value.
]]

local path_get_value = request('path_get_value')

return
  function(node, path, value)
    node = path_get_value(node, path, -2)
    node[path[#path]] = value
  end
