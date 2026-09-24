-- Return shell command to list all files in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-24
]]

local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

return
  function(dir_name)
    -- "find" starts talking shit if you place "type" before "maxdepth"
    local Command =
      {
        'find',
        {
          normalize(dir_name),
          '-maxdepth',
          '1',
          '-type',
          'f',
        },
      }

    return ShellCommand.create(Command)
  end

--[[
  2019 #
  2024 #
  2026 # # # #
]]
