local unquote = request('unquote_field')

return
  function(data_struc)
    assert_table(data_struc)
    local result = {}
    --parser adds empty record if last line ends with NL
    if (#data_struc[#data_struc] == 1) then
      data_struc[#data_struc] = nil
    end
    for i = 1, #data_struc do
      local rec = data_struc[i]
      result[i] = {}
      for j = 1, #rec do
        local field = rec[j]
        local value = field.value
        if (field.name == 'quoted_data') then
          value = unquote(value)
        end
        result[i][j] = value
      end
    end
    return result
  end
