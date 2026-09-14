-- For given string with bytecode return string with decompiled text

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local os_tmpname = os.tmpname
local file_from_str = request('!.convert.file_from_str')
local get_cmd_decompile = request('!.mechs.cmdline.get_cmd_decompile_lua_bytecode')
local remove_file = request('!.file_system.file.remove')

-- Export:
return
  function(bytecode_str)
    local output_str

    local bytecode_file_name = os_tmpname()

    file_from_str(bytecode_file_name, bytecode_str)

    local Command = get_cmd_decompile(bytecode_file_name)
    local is_ok, Results = Command:Execute()

    if not is_ok then
      output_str = ''
    else
      output_str = Results.output
    end

    remove_file(bytecode_file_name)

    return output_str
  end

--[[
  2026 #
]]
