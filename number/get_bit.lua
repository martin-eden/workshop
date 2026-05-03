-- Get bit from given integer

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

--[[
  Result structure

    boolean
]]

-- Imports:
local assert_bit_offs = request('assert_bit_offs')

local get_bit =
  function(n, bit_offs)
    assert_integer(n)
    assert_integer(bit_offs)
    assert_bit_offs(bit_offs)

    return (n & (1 << bit_offs) ~= 0)
  end

-- Export:
return get_bit

--[[
  2019
  2026-05-03
  2026-05-04
]]
