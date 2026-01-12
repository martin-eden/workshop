-- Return shell command to change current directory. GNU/Bash.

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local CommandFmt = 'cd %s'

local QuoteFilename = request('!.concepts.BashString.Quote')

return
  function(Path)
    Path = QuoteFilename(Path)
    local Command = string.format(CommandFmt, Path)
    return Command
  end

--[[
  2024-02-19
  2024-10-21
  2026-01-12
]]
