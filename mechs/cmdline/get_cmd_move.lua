-- Return shell command to move file to another name/location

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(src_name, dest_name)
    local command =
      { 'mv', normalize(src_name), normalize(dest_name) }

    return shell_command.create(command)
  end

--[[
  2018 #
  2024 #
  2026 # # # #
]]
