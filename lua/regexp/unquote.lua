-- Regexp-unquote of given string

--[[
  Author: Martin Eden
  Last mod.: 2026-10-14
]]

local magic_char_pattern = request('magic_char_pattern')
local replace_pattern = '%%(' .. magic_char_pattern .. ')'
local str_gsub = string.gsub

return
  function(str)
    return str_gsub(str, replace_pattern, '%1')
  end

--[[
  2018 #
]]
