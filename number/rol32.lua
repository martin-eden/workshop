--[[
  ROL32 with argument checks for early errors detection.
]]

local rol = request('rol32_')

return
  function(n, num_bits)
    assert_integer(n)
    assert_integer(num_bits)
    assert((num_bits >= 0) and (num_bits <= 32))
    return rol(n, num_bits)
  end
