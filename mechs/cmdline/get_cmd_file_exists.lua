-- Return shell command to check that pathname is existing file

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(pathname)
    local command = { 'test', '-f', normalize(pathname) }

    return shell_command.create(command)
  end

--[[
  2026 #
]]
