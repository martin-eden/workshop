-- Return shell command to decompile Lua file and print listing

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local ShellCommand = request('!.concepts.ShellCommand')

local get_cmd_decompile_lua_bytecode =
  function(bytecode_file_name)
    local Command =
      {
        'luac',
        {
          '-l',
          '-p',
          normalize(bytecode_file_name),
        },
      }

    return ShellCommand.create(Command):ToString()
  end

-- Export:
return get_cmd_decompile_lua_bytecode

--[[
  2026-07-14
]]
