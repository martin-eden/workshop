-- Insert given integer into specified bit range

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

-- Imports:
local assert_bit_offs = request('assert_bit_offs')

local set_bits =
  function(value, start_offs, end_offs, existing_value)
    existing_value = is_nil(existing_value) and 0 or existing_value

    assert_integer(existing_value)

    assert_integer(value)
    assert(value >= 0)

    assert_bit_offs(start_offs)
    assert_bit_offs(end_offs)
    assert(start_offs <= end_offs)

    -- Example for ( start_offs: 2, end_offs: 5 )
    -- mask: 00111111
    local addition_mask = (1 << (end_offs + 1)) - 1
    -- mask: 00111100
    addition_mask = addition_mask & ~((1 << start_offs) - 1)

    -- mask: 11000011
    local preserving_mask = ~addition_mask

    value = value << start_offs

    return (existing_value & preserving_mask) | (value & addition_mask)
  end

-- Export:
return set_bits

--[[
  2019
  2020
  2026-05-09
  2026-05-11
]]
