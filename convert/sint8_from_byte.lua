-- Unpack sint8 from byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')

local sint8_from_byte =
  function(byte)
    assert_byte(byte)

    return string.unpack('b', string.pack('B', byte))
  end

-- Export:
return sint8_from_byte

--[[
  2019
  2025-05-05
]]
