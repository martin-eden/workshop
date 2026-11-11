-- Return shell command to sleep for given amount of seconds

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local str_format = string.format
local shell_command = request('!.concepts.shell_command')

return
  function(seconds)
    -- Seconds may be fractional number
    local command = { 'sleep', str_format('%.2f', seconds) }

    return shell_command.create(command)
  end

--[[
  2020 #
  2026 # #
]]
