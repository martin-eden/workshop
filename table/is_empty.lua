-- Return true when table has no entries, false otherwise.

-- 2024-02-17

return
  function(t)
    assert_table(t)
    return is_nil(next(t))
  end
