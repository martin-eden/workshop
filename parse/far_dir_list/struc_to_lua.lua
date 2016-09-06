local struc_to_lua =
  function(data_struc)
    local result = {}
    for i = 1, #data_struc do
      local rec = data_struc[i]
      -- assert(rec.name == 'record')
      local node = result
      for deep = 1, #rec do
        local field = rec[deep]
        -- assert(field.name == 'field')
        local value = field.value
        if (value == '') then
          break
        end
        -- assert_string(value)
        node[value] = node[value] or {}
        node = node[value]
      end
    end
    return result
  end

return struc_to_lua
