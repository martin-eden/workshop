-- Convert string of bits to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

-- Imports:
local set_bit = request('!.number.set_bit')

local BitcharToBit =
  {
    ['X'] = true,
    ['.'] = false,
  }

local byte_from_bits =
  function(bits_str)
    assert_string(bits_str)

    local limit = string.len(bits_str)

    if (limit > 8) then limit = 8 end

    local result = 0

    for pos = 1, limit do
      local bit_char = string.sub(bits_str, pos, pos)
      result = set_bit(result, pos - 1, BitcharToBit[bit_char])
    end

    return result
  end

-- Export:
return byte_from_bits

--[[
  2026-05-07
]]
