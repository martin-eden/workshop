local get_max_idx = request('^.table.get_max_n')

local length_func =
  function(t)
    local mt = getmetatable(t)
    assert_table(mt)
    assert_integer(mt.array_length)
    return mt.array_length
  end

local from_table =
  function(t, length)
    assert_table(t)
    length = length or get_max_idx(t) or 0
    assert_integer(length)
    setmetatable(
      t,
      {
        is_array = true,
        array_length = length,
        __len = length_func,
      }
    )
  end

return from_table
