-- Execute shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

local <const> file_as_string = request('!.file_system.file.as_string')
local <const> get_execute_command =
  request('!.mechs.cmdline.get_cmd_execute_with_redirects')

--[[
  Execute shell command and capture results

  Executes given string as shell (OS-dependent) command.
  Captures termination code / return code, output and errors.

  Input

    [s] command -- Shell command to execute

  Output

    [t]
      [i] ResultCode -- Return code in case of normal ending
      [i] TerminationCode -- Termination code (signal number) in
        case of aborted ending
      [s] Output -- Program output
      [s] Errors -- Program errors
    }
]]
local <const> execute_shell_command =
  function(command)
    local <const> out_file_name = os.tmpname()
    local <const> errors_file_name = os.tmpname()

    local <const> shell_command =
      get_execute_command(
        command, out_file_name, errors_file_name
      )

    local <const> _, result_type_code, result_code =
      os.execute(shell_command)

    local <const> Result = {}

    if (result_type_code == 'exit') then
      Result.ResultCode = result_code
    end
    if (result_type_code == 'signal') then
      Result.TerminationCode = result_code
    end

    Result.Output = file_as_string(out_file_name)
    Result.Errors = file_as_string(errors_file_name)

    os.remove(out_file_name)
    os.remove(errors_file_name)

    return Result
  end

-- Export:
return execute_shell_command

--[[
  2026-04-17
]]
