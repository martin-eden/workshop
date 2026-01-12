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

-- Return true if file name contains symbols that require quoting
local NeedsQuoting =
  function(FileName)
    --[[
      Implementation uses plan-text scan

      We can use regexps to check for ["], [$] and [ ] in one run
      but today I value code clarity more than performance.
    ]]
    if string.find(FileName, '"', 1, true) then
      return true
    end

    if string.find(FileName, '$', 1, true) then
      return true
    end

    if string.find(FileName, ' ', 1, true) then
      return true
    end

    return false
  end

local QuoteFilename =
  function(FileName)
    if not NeedsQuoting(FileName) then
      return FileName
    end
    FileName = EscapeQuote(FileName)
    FileName = EscapeDollar(FileName)
    return '"' .. FileName .. '"'
  end

return QuoteFilename

-- 2026-01-12
