-- Return shell command to decompile Lua file and print listing

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

-- Imports:
local normalize = request('!.concepts.path_name.normalize')
local quote = request('!.concepts.shell.quote')
local glue_words = request('!.concepts.words.to_string')

local get_cmd_decompile_lua_bytecode =
  function(bytecode_file_name)
    bytecode_file_name = normalize(bytecode_file_name)

    local Command =
      {
        'luac',
        '-l',
        '-p',
        quote(bytecode_file_name)
      }

    return glue_words(Command)
  end

-- Export:
return get_cmd_decompile_lua_bytecode

--[[
  2026-07-14
]]
