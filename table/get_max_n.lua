local get_max_n =
  function(t)
    assert_table(t)
    local result
    for k, v in pairs(t) do
      if is_number(k) and is_integer(k) then
        if not result or (k > result) then
          result = k
        end
      end
    end
    return result
  end

return get_max_n
