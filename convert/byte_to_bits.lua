-- Convert byte to string of bits

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local assert_byte = request('!.number.assert_byte')
local get_bit = request('!.number.get_bit')
local bit_char = request('!.concepts.bit_chars').bit_to_char_map

return
  function(byte)
    assert_byte(byte)
    local bits_str = ''
    for offs = 0, 7 do
      bits_str = bits_str .. bit_char[get_bit(byte, offs)]
    end
    return bits_str
  end

--[[
  2026 #
]]
