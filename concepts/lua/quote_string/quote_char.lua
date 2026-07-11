-- Quote one character

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

local str_format = string.format
local str_byte = string.byte

local quote_char_fmt = [[\]] .. '%03d'

local quote_char =
  function(char)
    return str_format(quote_char_fmt, str_byte(char))
  end

-- Export:
return quote_char

--[[
  2026-07-12
]]
