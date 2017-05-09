return
  function(data_struc)
    local result = {}
    for i = 1, #data_struc do
      local rec = data_struc[i]
      -- assert(rec.type == 'record')
      local node = result
      for deep = 1, #rec do
        local field = rec[deep]
        -- assert(field.type == 'field')
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
