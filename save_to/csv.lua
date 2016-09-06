local quote = request('^.compile.csv.quote_field_smart')
local matrix_to_csv =
  function(m)
    local result = {}
    for i = 1, #m do
      local line = {}
      for j = 1, #m[i] do
        local field = m[i][j]
        field = tostring(field)
        line[j] = quote(field)
      end
      line = table.concat(line, ',')
      result[i] = line
    end
    result = table.concat(result, '\n')
    result = result .. '\n'
    return result
  end

local record_to_csv =
  function(r)
    local m = {r}
    local result = matrix_to_csv(m)
    return result
  end

local table_to_record
do
  local table_iterator = request('^.table.ordered_pass')
  local result
  local linearize
  linearize =
    function(node, prefix)
      if is_table(node) then
        for k, v in table_iterator(node) do
          local key = k
          if is_number(key) then
            key = tostring(key)
          end
          if is_string(key) then
            if (prefix ~= '') then
              key = prefix .. '.' .. key
            end
            if is_table(v) then
              linearize(v, key)
            elseif is_number(v) or is_string(v) then
              result[#result + 1] = {key = key, value = v}
            end
          end
        end
      end
    end

  table_to_record =
    function(t)
      result = {}
      linearize(t, '')
      local header = {}
      local data = {}
      for i = 1, #result do
        header[i] = result[i].key
        data[i] = result[i].value
      end
      return data, header
    end
end

return
  {
    table_to_record = table_to_record,
    record_to_csv = record_to_csv,
    matrix_to_csv = matrix_to_csv,
  }
