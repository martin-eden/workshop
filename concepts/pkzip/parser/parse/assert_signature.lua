--[[
  Assert that actual signature matches expected one.
]]

return
  function(actual_sign, expected_sign, offset)
    assert_string(actual_sign)
    assert_string(expected_sign)
    assert_integer(offset)

    if (actual_sign ~= expected_sign) then
      local msg =
        ('Signature mismatch. (at %d) %q ~= %q)'):
        format(offset, actual_sign, expected_sign)
      error(msg, 2)
    end
  end
