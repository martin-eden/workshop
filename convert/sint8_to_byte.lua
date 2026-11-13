-- Pack sint8 to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local in_range = request('!.number.in_range')
local str_pack = string.pack
local str_unpack = string.unpack

return
  function(sint8_byte)
    assert_integer(sint8_byte)
    assert(in_range(sint8_byte, -128, 127))

    return str_unpack('B', str_pack('b', sint8_byte))
  end

--[[
  2019
  2026 # #
]]
