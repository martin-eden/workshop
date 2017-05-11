local make_compiler_structure
make_compiler_structure =
  function(node)
    local result

    local node_type = type(node)
    if
      (node_type == 'string') or
      (node_type == 'number') or
      (node_type == 'boolean') or
      (node_type == 'nil')
    then
      result = node
    elseif (node_type == 'table') then
      result = {}
      if is_array(node) then
        result.type = 'array'
        for i = 1, #node do
          result[#result + 1] = make_compiler_structure(node[i])
        end
      else
        result.type = 'object'
        for k, v in ordered_pass(t) do
          result[#result + 1] = make_compiler_structure(k)
          result[#result + 1] = make_compiler_structure(v)
        end
      end
    end

    return result
  end

return make_compiler_structure
