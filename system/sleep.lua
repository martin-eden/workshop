-- Delay for given amount of seconds (real number)

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local get_cmd_sleep = request('!.mechs.cmdline.get_cmd_sleep')

return
  function(secs)
    assert_number(secs)
    assert(secs > 0)

    get_cmd_sleep(secs):execute()
  end

--[[
  2020 #
  2026 #
]]
