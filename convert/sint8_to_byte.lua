-- Pack sint8 to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

local sint8_to_byte =
  function(sint8_byte)
    assert_integer(sint8_byte)

    return string.unpack('B', string.pack('b', sint8_byte))
  end

-- Export:
return sint8_to_byte

--[[
  2019
  2026-05-05
]]
