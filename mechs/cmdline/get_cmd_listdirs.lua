--[[
  Return shell command to list all directories in given directory.

  GNU/Bash assumed.
]]

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local CommandFmt = 'find %s -maxdepth 1 -type d'

local QuoteFilename = request('quote_filename')

return
  function(DirName)
    DirName = QuoteFilename(DirName)
    local Command = string.format(CommandFmt, DirName)
    return Command
  end

--[[
  2019-12-01
  2024-10-21
  2026-01-12
]]
