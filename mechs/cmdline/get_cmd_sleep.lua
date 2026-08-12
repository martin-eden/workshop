-- Return shell command to sleep for given amount of seconds

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local str_format = string.format
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(seconds)
    -- Seconds may be fractional number
    local Command =
      { 'sleep', { str_format('%.2f', seconds) } }

    return ShellCommand.create(Command)
  end

--[[
  2020 #
  2026 # #
]]
