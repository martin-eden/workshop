--[[
  Return shell command to create directory.

  GNU/bash assumed.
]]

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local CommandFmt = 'mkdir -p %s'

local QuoteFilename = request('!.concepts.BashString.Quote')

return
  function(DirName)
    DirName = QuoteFilename(DirName)
    local Command = string.format(CommandFmt, DirName)
    return Command
  end

--[[
  2018-02-05
  2024-10-21
  2026-01-12
]]
