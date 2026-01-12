--[[
  Return shell command to copy file to another name/location.

  GNU/bash assumed.
]]

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local CommandFmt = 'cp %s %s'

local QuoteFilename = request('quote_filename')

return
  function(SourceName, DestName)
    SourceName = QuoteFilename(SourceName)
    DestName = QuoteFilename(DestName)
    local Command = string.format(CommandFmt, SourceName, DestName)
    return Command
  end

--[[
  2018-02-05
  2024-10-21
  2026-01-12
]]
