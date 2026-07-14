-- For given string with bytecode return string with decompiled text

--[[
  Author: Martin Eden
  Last mod.: 2026-07-13
]]

local get_listing =
  function(bytecode_str)
    local output_str
    do
      local bytecode_file_name = os.tmpname()

      do
        local file_from_str = request('!.convert.file_from_str')
        file_from_str(bytecode_str, bytecode_file_name)
      end

      do
        local get_cmd_decompile = request('!.mechs.cmdline.get_cmd_decompile_lua_bytecode')

        local shell_command = get_cmd_decompile(bytecode_file_name)

        local run_shell_command = request('!.concepts.shell.execute')
        local is_ok, Results = run_shell_command(shell_command)

        output_str = Results.output
      end

      do
        local rmfile = request('!.file_system.file.remove')

        rmfile(bytecode_file_name)
      end
    end

    return output_str
  end

-- Export:
return get_listing

--[[
  2026-07-13
]]
