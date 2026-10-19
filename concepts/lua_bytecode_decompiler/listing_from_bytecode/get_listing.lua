-- For given string with bytecode return string with decompiled text

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

local os_tmpname = os.tmpname
local file_from_str = request('!.convert.file_from_str')
local get_cmd_decompile =
  request('!.mechs.cmdline.get_cmd_decompile_lua_bytecode')
local remove_file = request('!.file_system.file.remove')

return
  function(bytecode_str)
    local bytecode_file_name = os_tmpname()

    file_from_str(bytecode_file_name, bytecode_str)

    local Command = get_cmd_decompile(bytecode_file_name)
    local is_ok, Results = Command:Execute()

    remove_file(bytecode_file_name)

    if not is_ok then return '' end

    return Results.output
  end

--[[
  2026 #
]]
