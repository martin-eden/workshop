-- Add quotes to file name to use it as string argument

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

--[[
  Historical note

  File name can have ["].

  We used [string.format("%q", s)] to change ["] to [\"].

  File name can have [$].

  "%q" is for Lua. "$" is okay in Lua string. But not in Bash
  commands. There it's used as variable name prefix

  So this function is written to handle ["] and [$] without hacks.
]]

local EscapeQuote = request('escape_quote')
local EscapeDollar = request('escape_dollar')

local QuoteFilename =
  function(s)
    s = EscapeQuote(s)
    s = EscapeDollar(s)
    return '"' .. s .. '"'
  end

return QuoteFilename

-- 2026-01-12
