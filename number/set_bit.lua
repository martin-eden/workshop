-- Set bit in given integer

--[[
  Author: Martin Eden
  Last mod.: 2026-05-07
]]

--[[
  Input structure

    [i] -- source integer
    [i] -- bit offset
    [b] -- bit value
]]

-- Imports:
local assert_bit_offs = request('assert_bit_offs')

local set_bit =
  function(n, bit_offs, bit_val)
    assert_integer(n)
    assert_bit_offs(bit_offs)
    assert_boolean(bit_val)

    if bit_val then
      n = n | (1 << bit_offs)
    else
      n = n & ~(1 << bit_offs)
    end

    return n
  end

-- Export:
return set_bit

--[[
  2019
  2026-05-07
]]
