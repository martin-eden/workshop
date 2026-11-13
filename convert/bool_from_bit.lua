-- Convert bit to boolean

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  It's frontend code

  We're aiming for cleaner code and not binding bitchar values.
]]

local char_to_bit_map = request('!.concepts.bit_chars').char_to_bit_map
local str_format = string.format

return
  function(bit_char)
    local result = char_to_bit_map[bit_char]
    if not is_boolean(result) then
      error(str_format('Wrong bit character %q.', bit_str))
    end
    return result
  end

--[[
  2026 # #
]]
