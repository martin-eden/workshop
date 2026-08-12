-- Return shell command to change current directory

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(dir_name)
    local Command = { 'cd', { normalize(dir_name) } }

    return ShellCommand.create(Command)
  end

--[[
  2024 # #
  2026 # # # #
]]
