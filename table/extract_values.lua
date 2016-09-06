local extract_values =
  function(t)
    assert_table(t)
    local result = {}
    for k, v in pairs(t) do
      result[#result + 1] = v
    end
    return result
  end

return extract_values
