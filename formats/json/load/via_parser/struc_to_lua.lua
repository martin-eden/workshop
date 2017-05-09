local unquote_string = request('^.unquote_string')
local to_array = request('!.mechs.array.from_table')

return
  function(stream, data_struc)
    assert_table(data_struc)

    local get_value =
      function(node)
        return stream:get_segment(node.start, node.len)
      end

    local struc_to_lua
    struc_to_lua =
      function(node)
        local result
        if (node.type == 'object') then
          result = {}
          local i = 1
          while (i + 1 <= #node) do
            local key = struc_to_lua(node[i])
            local value = struc_to_lua(node[i + 1])
            result[key] = value
            i = i + 2
          end
        elseif (node.type == 'array') then
          result = {}
          for i = 1, #node do
            result[i] = struc_to_lua(node[i])
          end
          to_array(result, #node)
        elseif (node.type == 'string') then
          result = unquote_string(get_value(node))
        elseif (node.type == 'number') then
          result = tonumber(get_value(node))
        elseif (node.type == 'boolean') then
          local value = get_value(node)
          if (value == 'true') then
            result = true
          elseif (value == 'false') then
            result = false
          end
        elseif (node.type == 'null') then
          result = nil
        end

        return result
      end

    return struc_to_lua(data_struc)
  end
