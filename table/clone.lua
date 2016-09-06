local clone_outer =
  function(node)
    local cloned = {}
    local clone
    clone =
      function(node)
        if is_table(node) then
          local result
          if cloned[node] then
            result = cloned[node]
          else
            result = {}
            cloned[node] = result
            for k, v in pairs(node) do
              result[clone(k)] = clone(v)
            end
            setmetatable(result, getmetatable(node))
          end
          return result
        else
          return node
        end
      end
    return clone(node)
  end

return clone_outer

--[[
  Metatables is shared, not cloned.
]]
