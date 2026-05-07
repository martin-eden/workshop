-- Convert byte to string of bits

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local get_bit = request('!.number.get_bit')

local BitToBitchar =
  {
    [true]  = 'X',
    [false] = '.',
  }

local byte_to_bits =
  function(byte)
    assert_byte(byte)

    local bits_str = ''

    for offs = 0, 7 do
      bits_str = bits_str .. BitToBitchar[get_bit(byte, offs)]
    end

    return bits_str
  end

-- Export:
return byte_to_bits

--[[
  2026-05-07
]]
