-- Return shell command to decompile Lua file and print listing

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local normalize = request('!.concepts.path_name.normalize')
local shell_command = request('!.concepts.shell_command')

return
  function(bytecode_file_name)
    local command =
      {
        'luac',
        '-l',
        '-p',
        normalize(bytecode_file_name),
      }

    return shell_command.create(command)
  end

--[[
  2026 # #
]]
