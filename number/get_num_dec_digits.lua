-- Get number of decimal digits in integer

--[[
  Author: Martin Eden
  Last mod.: 2026-07-04
]]

-- Imports:
local assert_integer = _G.assert_integer
local abs = math.abs
local log_10 = math.log10
local floor = math.floor

local get_num_dec_digits =
  function(n)
    assert_integer(n)

    if (n == 0) then return 1 end

    return floor(log_10(abs(n))) + 1
  end

-- Export:
return get_num_dec_digits

--[[
  2026-07-04
]]
