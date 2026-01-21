-- Return shell command to delete directory. GNU/bash assumed.

--[[
  Author: Martin Eden
  Last mod.: 2026-01-21
]]

local CommandFmt = 'rm -r %s'

local QuoteFilename = request('!.concepts.BashString.Quote')

return
  function(DirName)
    DirName = QuoteFilename(DirName)
    local Command = string.format(CommandFmt, DirName)
    return Command
  end

--[[
  2018-12-08
  2024-02-17
  2024-10-21
  2026-01-12
]]
