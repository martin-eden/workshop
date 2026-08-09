-- Return shell command to sleep for given amount of seconds

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local ShellCommand = request('!.concepts.ShellCommand')
local str_format = string.format

-- Export:
return
  function(seconds)
    -- Seconds may be fractional number
    local Command =
      { 'sleep', { str_format('%.2f', seconds) } }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2020 #
  2026-04-17
]]
