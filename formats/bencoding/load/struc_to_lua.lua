local to_array = request('!.mechs.array.from_table')

local struc_to_lua
struc_to_lua =
  function(data_struc)
    local name, value = data_struc.name, data_struc.value
    local result
    if (name == 'string') then
      result = value
    elseif (name == 'integer') then
      result = tonumber(value)
    elseif (name == 'dictionary') then
      result = {}
      local i = 1
      while (i + 1 <= #data_struc) do
        local key = struc_to_lua(data_struc[i])
        local value = struc_to_lua(data_struc[i + 1])
        result[key] = value
        i = i + 2
      end
    elseif (name == 'list') then
      result = {}
      for i = 1, #data_struc do
        result[i] = struc_to_lua(data_struc[i])
      end
      to_array(result, #data_struc)
    else
      error(('Unknown data type: "%s". (%s)'):format(name, value))
    end

    return result
  end

return
  function(data_struc)
    if not data_struc.name and (#data_struc == 1) then
      data_struc = data_struc[1]
    end
    return struc_to_lua(data_struc)
  end
