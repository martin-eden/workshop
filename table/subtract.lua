--[[
  From table <a> remove key-value pairs that present in table <b>.
  Return nothing.
]]

return
  function(a, b)
    assert_table(a)
    assert_table(b)
    for k in pairs(b) do
      if a[k] and (a[k] == b[k]) then
        a[k] = nil
      end
    end
  end
