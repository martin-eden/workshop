-- Return shell command to move file to another name/location

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(src_name, dest_name)
    local Command =
      {
        'mv',
        {
          normalize(src_name),
          normalize(dest_name),
        },
      }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2018 #
  2024 #
  2026 # # #
]]
