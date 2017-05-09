local to_array = request('!.mechs.array.from_table')

return
  function(stream, data_struc)

    local struc_to_lua
    struc_to_lua =
      function(node)
        local result
        if (node.type == 'string') then
          result = stream:get_segment(node.start, node.len)
        elseif (node.type == 'integer') then
          result = stream:get_segment(node.start, node.len)
          result = tonumber(result)
        elseif (node.type == 'dictionary') then
          result = {}
          local i = 1
          while (i + 1 <= #node) do
            local key = struc_to_lua(node[i])
            local value = struc_to_lua(node[i + 1])
            result[key] = value
            i = i + 2
          end
        elseif (node.type == 'list') then
          result = {}
          for i = 1, #node do
            result[i] = struc_to_lua(node[i])
          end
          to_array(result, #node)
        else
          error(('Unknown node type: "%s"'):format(node.type))
        end

        return result
      end

    return struc_to_lua(data_struc)
  end
