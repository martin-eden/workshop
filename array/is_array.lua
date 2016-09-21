return
  function(t)
    assert_table(t)
    local mt = getmetatable(t)
    return mt and (mt.is_array == true)
  end
