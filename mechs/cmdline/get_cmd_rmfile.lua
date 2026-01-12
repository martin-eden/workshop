-- Get GNU/Bash command to remove file by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local CommandFmt = 'rm %s'

local QuoteFilename = request('!.concepts.BashString.Quote')

return
  function(PathName)
    PathName = QuoteFilename(PathName)
    local Command = string.format(CommandFmt, PathName)
    return Command
  end

--[[
  2024-02-13
  2024-10-21
  2026-01-12
]]
