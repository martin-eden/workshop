-- Return shell command to list all directories in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
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
          '-maxdepth',
          '1',
          '-mindepth',
          '1',
          '-type',
          'd',
        },
      }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2019 #
  2024 #
  2026 # # # # #
]]
