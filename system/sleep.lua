-- Delay for given amount of seconds (real number)

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local get_cmd_sleep = request('!.mechs.cmdline.get_cmd_sleep')

--[[
  Sleep for given real number of seconds
]]
local sleep =
  function(secs)
    assert_number(secs)
    assert(secs > 0)

    get_cmd_sleep(secs):Execute()
  end

-- Export:
return sleep

--[[
  2020 #
  2026 #
]]
