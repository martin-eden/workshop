local unquote_string = request('unquote_string')
local to_array = request('^.^.array.from_table')

local struc_to_lua
struc_to_lua =
  function(data_struc)
    local name, value = data_struc.name, data_struc.value
    local result
    if (name == 'object') then
      result = {}
      local i = 1
      while (i + 1 <= #data_struc) do
        local key = struc_to_lua(data_struc[i])
        local value = struc_to_lua(data_struc[i + 1])
        result[key] = value
        i = i + 2
      end
    elseif (name == 'key') then
      result = struc_to_lua(data_struc[1])
    elseif (name == 'value') then
      result = struc_to_lua(data_struc[1])
    elseif (name == 'array') then
      result = {}
      for i = 1, #data_struc do
        result[i] = struc_to_lua(data_struc[i])
      end
      to_array(result, #data_struc)
    elseif (name == 'string') then
      result = unquote_string(data_struc.value)
    elseif (name == 'number') then
      result = tonumber(value)
    elseif (name == 'boolean') then
      if (value == 'true') then
        result = true
      elseif (value == 'false') then
        result = false
      end
    elseif (name == 'null') then
      result = nil
    end

    return result
  end

return
  function(data_struc)
    assert_table(data_struc)
    local result
    if
      not data_struc.name and
      not data_struc.value and
      (#data_struc == 1)
    then
      result = struc_to_lua(data_struc[1])
    else
      result = struc_to_lua(data_struc)
    end
    return result
  end
