-- Return shell command to list all files in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-08
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(dir_name)
    local Command =
      {
        'find',
        {
          normalize(dir_name),
          '-type',
          'f',
          '-maxdepth',
          '1',
        },
      }

    return ShellCommand.create(Command)
  end

--[[
  2019 #
  2024 #
  2026 # # # #
]]
