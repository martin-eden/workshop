-- Quote one character

--[[
  Author: Martin Eden
  Last mod.: 2026-08-13
]]

local quote_char_fmt = [[\%03d]]
local str_byte = string.byte
local str_format = string.format

return
  function(char)
    return str_format(quote_char_fmt, str_byte(char))
  end

--[[
  2026-07-12
]]
