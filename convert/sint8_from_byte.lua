-- Unpack sint8 from byte

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local assert_byte = request('!.number.assert_byte')
local str_pack = string.pack
local str_unpack = string.unpack

return
  function(byte)
    assert_byte(byte)
    return str_unpack('b', str_pack('B', byte))
  end

--[[
  2019
  2025 #
]]
