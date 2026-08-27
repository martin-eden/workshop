-- Return map with count of used ASCII characters codes in string

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local str_sub = string.sub
local str_byte = string.byte

-- Export:
return
  function(str)
    local UsedChars_Map = { }

    for index = 1, #str do
      local code = str_byte(str_sub(str, index, index))

      if is_nil(UsedChars_Map[code]) then
        UsedChars_Map[code] = 0
      end

      UsedChars_Map[code] = UsedChars_Map[code] + 1
    end

    return UsedChars_Map
  end

--[[
  2026-07-12
]]
