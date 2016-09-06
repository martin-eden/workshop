local chunk_name = 'universal_handler'

local universal_handler =
  function(...)
    local result
    result = {...}
    for i = 1, #result do
      result[i] = tostring(result[i])
    end
    result = table.concat(result, ', ')
    print(result)
    -- return result
  end

tribute(chunk_name, universal_handler)
