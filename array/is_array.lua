local is_array =
  function(t)
    assert_table(t)
    local mt = getmetatable(t)
    if mt and (mt.is_array == true) then
      return true
    end
    return false
  end

return is_array
