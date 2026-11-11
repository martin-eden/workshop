-- Return shell command to set "executable" attribute for file

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(file_name)
    local command = { 'chmod', '+x', normalize(file_name) }

    return shell_command.create(command)
  end

--[[
  2026-09-24
]]
