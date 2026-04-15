-- Execute OS shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-04-15
]]

--[[
  Execute OS shell command
]]
local ExecuteCommand =
  function(Command)
    assert_string(Command)

    assert(os.execute(Command))
  end

-- Export:
return ExecuteCommand

--[[
  2026-04-15
]]
