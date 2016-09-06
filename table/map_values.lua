local map_values =
  function(t)
    assert_table(t)
    local result = {}
    for k, v in pairs(t) do
      result[v] = true
    end
    return result
  end

return map_values
