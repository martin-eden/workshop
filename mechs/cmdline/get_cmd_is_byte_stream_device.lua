-- Return shell command to check that pathname is "character device"

--[[
  Author: Martin Eden
  Last mod.: 2026-11-04
]]

--[[
  "Character device" means stream with byte granularity
  in normal world.
]]

local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

return
  function(pathname)
    local Command = { 'test', { '-c', normalize(pathname) } }

    return ShellCommand.create(Command)
  end

--[[
  2026-11-04
]]
