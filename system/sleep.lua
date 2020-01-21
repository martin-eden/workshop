--[[
  Delay of given number of seconds (real number).

  Using system "sleep" function but it is OS-dependent.
  GNU/bash assumed.
]]

local get_cmd_sleep = request('!.bare.file_system.get_cmd_sleep')

return
  function(secs)
    assert_number(secs)
    assert(secs > 0)
    local cmd = get_cmd_sleep(secs)
    os.execute(cmd)
  end
