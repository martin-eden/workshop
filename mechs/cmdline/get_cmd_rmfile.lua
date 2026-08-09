-- Return shell command to remove file by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

-- Export:
return
  function(file_name)
    local Command =
      { 'rm', { normalize(file_name) } }

    return ShellCommand.create(Command):ToString()
  end

--[[
  2024 # #
  2026 # # #
]]
