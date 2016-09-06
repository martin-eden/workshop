local struc_handlers = {}

local process_node =
  function(node)
    -- assert_table(node)
    if is_table(node) then
      local handler = struc_handlers[node.name]
      if handler then
        handler(node)
      else
        io.write('<' .. node.name .. '>')
      end
    end
  end

local process_list =
  function(node)
    for i = 1, #node do
      process_node(node[i])
    end
  end

local struc_to_lua =
  function(data_struc)
    assert_table(data_struc)
    local result = data_struc
    for i = 1, #data_struc do
      process_node(data_struc[i])
    end

    return result
  end

return struc_to_lua
