-- Convert boolean to bit

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local bit_to_char_map = request('!.concepts.bit_chars').bit_to_char_map

return
  function(bit_value)
    local bit_char = bit_to_char_map[bit_value]
    assert(bit_char)
    return bit_char
  end

--[[
  2026 # #
]]
