-- Check that given integer can be converted to BCD byte

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

local is_bcd_able =
  function(n)
    assert_integer(n)

    if (n < 0) then return false end
    if (n >= 100) then return false end

    return true
  end

-- Export:
return is_bcd_able

--[[
  2020
  2026-05-05
]]
