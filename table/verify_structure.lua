--[[
  Verify structure of given table versus reference table.

  Has option to generate missing data into passed table.

  Returns true if no issues were found.

  Reference table is ordinary Lua table. Valid value type in given
  table is type of value in reference table.

  For numbers we allow sample to be integer for float reference.

  So table {type = 'point_2d', x = 10.0, y = 0.0} matches
  reference {type = 'any string', x = 0.0, y = 1.1}.
]]

return
  function(sample, reference, generate_missing_data)
    assert_table(sample)
    assert_table(reference)
    local result = true

    local process_table
    process_table =
      function(sample, reference)
        for key, value in pairs(reference) do
          if
            (type(sample[key]) ~= type(value)) or
            (
              is_number(sample[key]) and
              not is_integer(sample[key]) and
              is_integer(value)
            )
          then
            result = false
            if generate_missing_data then
              sample[key] = value
            else
              break
            end
          end
          if is_table(value) then
            process_table(sample[key], value)
          end
        end
      end

    process_table(sample, reference)

    return result
  end
