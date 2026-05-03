-- Get 0-based index of most-significant-bit

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

-- Imports:
local get_bit = request('!.number.get_bit')

local get_msb =
  function(int)
    assert_integer(int)

    for i = 63, 0, -1 do
      if get_bit(int, i) then
        return i
      end
    end

    return 0
  end

-- Export:
return get_msb

--[[
  2019
  2026-05-03
]]
