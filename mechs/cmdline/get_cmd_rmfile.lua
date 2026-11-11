-- Return shell command to remove file by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(file_name)
    local command = { 'rm', normalize(file_name) }

    return shell_command.create(command)
  end

--[[
  2024 # #
  2026 # # # #
]]
