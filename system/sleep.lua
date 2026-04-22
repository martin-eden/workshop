-- Delay for given amount of seconds (real number)

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local get_cmd_sleep = request('!.mechs.cmdline.get_cmd_sleep')
local shell_execute = request('!.concepts.shell.execute')

--[[
  Sleep for given real number of seconds
]]
local sleep =
  function(secs)
    assert_number(secs)
    assert(secs > 0)

    local shell_cmd = get_cmd_sleep(secs)

    shell_execute(shell_cmd)
  end

-- Export:
return sleep

--[[
  2020 #
  2026-04-22
]]
