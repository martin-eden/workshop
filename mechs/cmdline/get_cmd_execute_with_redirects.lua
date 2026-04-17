-- Return shell command to execute given string with output redirects

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

local <const> Shell_QuoteString = request('!.concepts.shell.quote')

--[[
  Return command to execute command with stdout and stderr redirected
]]
local <const> Shell_GetCmd_ExecuteWithOutputRedirects =
  function(Command, OutputFileName, ErrorsFileName)
    local <const> QuotedCommand = Shell_QuoteString(Command)
    local <const> CommandAndArgs =
      {
        'sh',
        '-c', QuotedCommand,
        '1>' .. OutputFileName,
        '2>' .. ErrorsFileName,
      }
    local <const> WrappedCommand = table.concat(CommandAndArgs, ' ')

    return WrappedCommand
  end

-- Export:
return Shell_GetCmd_ExecuteWithOutputRedirects

--[[
  2026-04-17
]]
