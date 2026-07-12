-- Return map of used ASCII characters codes count in string

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

local str_sub = string.sub
local str_byte = string.byte

local get_chars_count =
  function(str)
    local UsedChars_Map = { }

    for index = 1, #str do
      local char = str_sub(str, index, index)
      local code = str_byte(char)

      if is_nil(UsedChars_Map[code]) then
        UsedChars_Map[code] = 0
      end

      UsedChars_Map[code] = UsedChars_Map[code] + 1
    end

    return UsedChars_Map
  end

-- Export:
return get_chars_count

--[[
  2026-07-12
]]
