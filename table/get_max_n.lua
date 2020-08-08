--[[
  Gets table. Returns maximum integer key of it.

  Table may still have holes from index 1 to this value.
]]

return
  function(t)
    assert_table(t)
    local result
    for key in pairs(t) do
      if
        is_integer(key) and
        (not result or (key > result))
      then
        result = key
      end
    end
    return result
  end
