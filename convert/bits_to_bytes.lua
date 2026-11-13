-- Convert string with bits to list of bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local str_sub = string.sub
local byte_from_bits = request('!.convert.byte_from_bits')
local add_to_list = request('!.concepts.list.add_item')

return
  function(bits_str)
    local bytes = { }
    for start_pos = 1, #bits_str, 8 do
      local slice = str_sub(bits_str, start_pos, start_pos + 8 - 1)
      add_to_list(bytes, byte_from_bits(slice))
    end
    return bytes
  end

--[[
  2026 # #
]]
