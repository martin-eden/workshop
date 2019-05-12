--[[
  Assert that passed value is integer in byte range.
]]

return
  function(v)
    assert_integer(v)
    if (v ~= v & 0xFF) then
      local msg =
        ('Given number 0x%X is not in byte range (0x00/0xFF)'):
        format(v)
      error(msg, 2)
    end
  end
