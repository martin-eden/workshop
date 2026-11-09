-- Escape string with HTML

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  That's experiment leftover

  At next version HTML was not used at all but function looks okay.
]]

local ascii_chars = request('!.concepts.ascii.chars')
local replacements =
  {
    [ascii_chars.ampersand] = '&amp;',
    [ascii_chars.less_than] = '&lt;',
    [ascii_chars.greater_than] = '&gt;',
    [ascii_chars.single_quote] = '&#39;',
    [ascii_chars.double_quote] = '&quot;',
  }
local str_gsub = string.gsub

return
  function(str)
    return str_gsub(str, '.', replacements)
  end

--[[
  2026-11-05
]]
