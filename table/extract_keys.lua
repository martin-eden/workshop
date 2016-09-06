local extract_keys =
  function(t)
    assert_table(t)
    local result = {}
    for k, v in pairs(t) do
      result[#result + 1] = k
    end
    return result
  end

return extract_keys
