--[[
  Assert that passed value is 0 or 1.
]]

return
  function(v)
    assert_integer(v)
    if (v ~= 0) and (v ~= 1) then
      local msg =
        ('Given number %d is not in bit range (0/1)'):format(v)
      error(msg, 2)
    end
  end
