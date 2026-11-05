-- Escape string with HTML

--[[
  Author: Martin Eden
  Last mod.: 2026-11-05
]]

--[[
  That's experiment leftover

  At next version HTML was not used at all but function looks okay.
]]

local AsciiChars = request('!.concepts.Ascii.Chars')
local Replacements =
  {
    [AsciiChars.ampersand] = '&amp;',
    [AsciiChars.less_than] = '&lt;',
    [AsciiChars.greater_than] = '&gt;',
    [AsciiChars.single_quote] = '&#39;',
    [AsciiChars.double_quote] = '&quot;',
  }
local str_gsub = string.gsub

return
  function(str)
    return str_gsub(str, '.', Replacements)
  end

--[[
  2026-11-05
]]
