-- Get specified bit range from integer number

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

-- Imports:
local assert_bit_offs = request('assert_bit_offs')

local slice_bits =
  function(n, start_offs, end_offs)
    assert_integer(n)
    assert_bit_offs(start_offs)
    assert_bit_offs(end_offs)

    assert(start_offs <= end_offs)

    local mask
    mask = (1 << (end_offs + 1)) - 1
    mask = mask & ~((1 << start_offs) - 1)

    return (n & mask) >> start_offs
  end

-- Export:
return slice_bits

--[[
  2019
  2026-05-09
]]
