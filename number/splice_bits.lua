-- Insert given integer into specified bit range.

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

-- Imports:
local assert_bit_offs = request('assert_bit_offs')

local splice_bits =
  function(v, start_offs, end_offs, n)
    n = is_nil(n) and 0 or n

    assert_integer(n)

    assert_integer(v)
    assert(v >= 0)

    assert_bit_offs(start_offs)
    assert_bit_offs(end_offs)
    assert(start_offs <= end_offs)

    if ((v << start_offs) > (1 << (end_offs + 1))) then
      error(
        string.format(
          'Value 0x%X is too large to fit given bit range [%d, %d].',
          v, start_offs, end_offs
        )
      )
    end

    -- Example for ( start_offs: 2, end_offs: 5 )
    local mask
    -- mask: 00111111
    mask = (1 << (end_offs + 1)) - 1
    -- mask: 00111100
    mask = mask & ~((1 << start_offs) - 1)
    -- mask: 00000011
    mask = ~mask

    return (n & mask) | (v << start_offs)
  end

-- Export:
return splice_bits

--[[
  2019
  2020
  2026-05-09
]]
