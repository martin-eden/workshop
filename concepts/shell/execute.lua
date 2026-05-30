-- Execute shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Input

    [s] command -- Shell command to execute

  Output

    [t]
      [b] is_aborted -- true in case of aborted execution
      [i] result_code -- Return code in case of normal ending.
        Termination code (signal number) in case of aborted ending.
      [s] output -- Program output
      [s] errors -- Program errors
    }
]]

-- Imports:
local file_to_str = request('!.convert.file_to_str')
local get_execute_command =
  request('!.mechs.cmdline.get_cmd_execute_with_redirects')

--[[
  Execute shell command and capture results

  Executes given string as shell (OS-dependent) command.
  Captures termination code / return code, output and errors.
]]
local execute_shell_command =
  function(command)
    local output_filename = os.tmpname()
    local error_filename = os.tmpname()

    local shell_command =
      get_execute_command(
        command, output_filename, error_filename
      )

    local _, result_type_code, result_code = os.execute(shell_command)

    local Result = { }

    if (result_type_code == 'exit') then
      Result.is_aborted = false
    elseif (result_type_code == 'signal') then
      Result.is_aborted = true
    end
    Result.result_code = result_code
    Result.output = file_to_str(output_filename)
    Result.error = file_to_str(error_filename)

    os.remove(output_filename)
    os.remove(error_filename)

    return Result
  end

-- Export:
return execute_shell_command

--[[
  2026-04-17
]]
