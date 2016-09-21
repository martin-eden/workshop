return
  function(t)
    assert_table(t)
    local result
    for k, v in pairs(t) do
      if
        is_number(k) and
        is_integer(k) and
        (not result or (k > result))
      then
        result = k
      end
    end
    return result
  end
