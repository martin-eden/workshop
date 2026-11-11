-- Return shell command to list all files in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(dir_name)
    -- "find" starts talking shit when you place "type" before "maxdepth"
    local command =
      {
        'find',
        normalize(dir_name),
        '-maxdepth',
        '1',
        '-type',
        'f',
      }

    return shell_command.create(command)
  end

--[[
  2019 #
  2024 #
  2026 # # # #
]]
