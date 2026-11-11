-- Return shell command to check that pathname is "character device"

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  "Character device" means stream with byte granularity
  in normal world.
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(pathname)
    local command = { 'test', '-c', normalize(pathname) }

    return shell_command.create(command)
  end

--[[
  2026 #
]]
