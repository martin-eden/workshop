-- Convert string of bits to byte

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local str_sub = string.sub
local char_to_bit_map = request('!.concepts.bit_chars').char_to_bit_map
local str_format = string.format
local set_bit = request('!.number.set_bit')

return
  function(bits_str)
    assert_string(bits_str)

    local limit = #bits_str

    if (limit > 8) then limit = 8 end

    local result = 0

    for pos = 1, limit do
      local bit_char = str_sub(bits_str, pos, pos)
      local bit = char_to_bit_map[bit_char]
      if not is_boolean(bit) then
        error(str_format('Invalid bit char %q.', bit_char))
      end
      result = set_bit(result, pos - 1, bit)
    end

    return result
  end

--[[
  2026-05-07
  2026-05-08
  2026-05-09
]]
