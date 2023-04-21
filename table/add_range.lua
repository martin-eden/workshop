--[[
  Set a segment of table keys to one value.
]]

return
  function(Table, KeyStart, KeyEnd, Value)
    assert_table(Table)
    assert_integer(KeyStart)
    assert_integer(KeyEnd)
    assert(KeyStart <= KeyEnd)

    for Key = KeyStart, KeyEnd do
      Table[Key] = Value
    end
  end
