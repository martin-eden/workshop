-- Return shell command to delete directory

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
        'rm',
        {
          '-r',
          '-f',
          normalize(dir_name),
        },
      }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2018 #
  2024 # #
  2026 # # #
]]
