-- Return shell command to change current directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(dir_name)
    local command = { 'cd', normalize(dir_name) }

    return shell_command.create(command)
  end

--[[
  2024 # #
  2026 # # # #
]]
