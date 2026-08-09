-- Return shell command to change current directory

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
    local Command = { 'cd', { normalize(dir_name) } }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2024 # #
  2026-01-12
  2026-04-17
  2026-04-28
]]
