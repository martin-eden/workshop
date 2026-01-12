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

  So this function is written to handle ["] and [$] (and others!)
  without hacks.
]]

local CharactersToQuote =
  {
    ' ',
    '"',
    '$',
    '`',
  }

local EscapeCharacter = [[\]]

local CharsToQuoteStr = table.concat(CharactersToQuote)

local QuoteRegexp = request('!.lua.regexp.quote')
local CharsToQuoteRegexpSet = '[' .. QuoteRegexp(CharsToQuoteStr) .. ']'
local CharToQuoteCapture = '(' .. CharsToQuoteRegexpSet .. ')'

local HasCharsFromRegexpSet =
  function(s, RegexpSetStr)
    return (string.find(s, RegexpSetStr) ~= nil)
  end

-- Return true if file name contains symbols that require quoting
local NeedsQuoting =
  function(FileName)
    return HasCharsFromRegexpSet(FileName, CharsToQuoteRegexpSet)
  end

-- "Defuse" all special characters
local Defuse =
  function(FileName)
    --[[
      Example data:

        string.gsub('a`b', '([ "$`])', '\%1') -> 'a\`b'

    ]]
    return string.gsub(FileName, CharToQuoteCapture, EscapeCharacter .. '%1')
  end

local QuoteFilename =
  function(FileName)
    if not NeedsQuoting(FileName) then
      return FileName
    end
    return '"' .. Defuse(FileName) .. '"'
  end

return QuoteFilename

-- 2026-01-12
