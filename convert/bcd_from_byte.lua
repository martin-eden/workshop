-- Convert byte to byte in BCD format

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local set_bits = request('!.number.set_bits')

return
  function(byte)
    return set_bits(byte // 10, 4, 7) | set_bits(byte % 10, 0, 3)
  end

--[[
  2019 # #
  2026 # # #
]]
