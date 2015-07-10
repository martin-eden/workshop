require('#base')

local chunk_name = 'table.clone'

local deep_copy
deep_copy =
  function(node)
    if is_table(node) then
      local result = {}
      for k, v in pairs(node) do
        result[deep_copy(k)] = deep_copy(v)
      end
      return result
    else
      return node
    end
  end

tribute(chunk_name, deep_copy)
