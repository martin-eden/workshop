-- Convert string of bits to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
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
      local bit = BitcharToBit[bit_char]
      if not is_boolean(bit) then
        error(string.format('Invalid bit char %q.', bit_char))
      end
      result = set_bit(result, pos - 1, bit)
    end

    return result
  end

-- Export:
return byte_from_bits

--[[
  2026-05-07
  2026-05-08
  2026-05-09
]]
