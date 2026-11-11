-- Return shell command to delete directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(dir_name)
    local command = { 'rm', '-r', '-f', normalize(dir_name) }

    return shell_command.create(command)
  end

--[[
  2018 #
  2024 # #
  2026 # # # #
]]
