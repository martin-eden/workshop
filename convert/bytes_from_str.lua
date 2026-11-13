-- Convert string to list of bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

-- This implementation is not designed for long strings

local str_byte = string.byte

return
  function(str)
    return { str_byte(str, 1, #str) }
  end

--[[
  2026 #
]]
