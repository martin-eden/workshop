-- Convert byte to string of bits

--[[
  Author: Martin Eden
  Last mod.: 2026-05-17
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local get_bit = request('!.number.get_bit')
local BitToChar_Map = request('!.concepts.BitChars').BitToChar_Map

local byte_to_bits =
  function(byte)
    assert_byte(byte)

    local bits_str = ''

    for offs = 0, 7 do
      bits_str = bits_str .. BitToChar_Map[get_bit(byte, offs)]
    end

    return bits_str
  end

-- Export:
return byte_to_bits

--[[
  2026-05-07
]]
