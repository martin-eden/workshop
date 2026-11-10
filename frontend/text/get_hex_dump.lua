-- Serialize string to ASCII hex

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

local str_byte = string.byte
local str_format = string.format
local str_gsub = string.gsub
local trim_tail = request('!.string.trim_tail')

local replace_char =
  function(char)
    return str_format('%02X ', str_byte(char, 1, 1))
  end

return
  function(raw_str)
    return trim_tail(str_gsub(raw_str, '.', replace_char))
  end

--[[
  2018 #
  2020 #
  2026 # #
]]
