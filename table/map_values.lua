local chunk_name = 'map_values'

local map_values =
  function(t)
    assert_table(t)
    local result = {}
    for k, v in pairs(t) do
      result[v] = k
    end
    return result
  end

tribute(chunk_name, map_values)
