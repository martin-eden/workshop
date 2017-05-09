local unquote = request('^.^.unquote_field')

return
  function(stream, data_struc)
    assert_table(data_struc)
    local result = {}
    --parser adds empty record if last line ends with NL
    if (#data_struc[#data_struc] == 1) then
      data_struc[#data_struc] = nil
    end
    for i = 1, #data_struc do
      local rec = data_struc[i]
      result[i] = {}
      local prev_field_type
      for j = 1, #rec do
        local field = rec[j]
        local value = stream:get_segment(field.start, field.len)
        if (field.type == 'unquoted_data') then
        elseif (field.type == 'quoted_data') then
          value = unquote(value)
        elseif (field.type == 'field_sep') then
          if (prev_field_type == 'field_sep') then
            value = ''
          end
        else
          value = nil
        end
        if value then
          table.insert(result[i], value)
        end
        prev_field_type = field.type
      end
      -- Handle "1," case:
      if (rec[#rec].type == 'field_sep') then
        table.insert(result[i], '')
      end
    end
    return result
  end
