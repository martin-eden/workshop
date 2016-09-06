local map_array =
  function(a, mapping)
    assert_table(a)
    assert_table(mapping)
    local result = {}
    for k, v in pairs(mapping) do
      result[v] = a[k]
    end
    return result
  end

return map_array
