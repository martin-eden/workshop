-- Regexp-unquote of given string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

local magic_charset = request('magic_charset')
local replace_pattern = '%%(' .. magic_charset .. ')'
local str_gsub = string.gsub

return
  function(str)
    return str_gsub(str, replace_pattern, '%1')
  end

--[[
  2018 #
]]
