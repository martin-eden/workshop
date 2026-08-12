-- Execute shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

--[[
  Input

    [s] command -- Shell command to execute

  Output

    [b] true if result code is 0
    [t]
      [b] is_aborted -- true in case of aborted execution
      [i] result_code -- Return code in case of normal ending.
        Termination code (signal number) in case of aborted ending.
      [s] output -- Program output
      [s] errors -- Program errors
    }
]]

--[[
  Execute shell command and capture results

  Executes given string as shell (OS-dependent) command.
  Captures termination code / return code, output and errors.
]]
local execute_shell_command
do
  local get_is_aborted
  do
    local normal_exit_str = 'exit'
    local aborted_exit_str = 'signal'

    get_is_aborted =
      function(result_type_code)
        if (result_type_code == normal_exit_str) then
          return false
        elseif (result_type_code == aborted_exit_str) then
          return true
        else
          error('Unknown termination status.')
        end
      end
  end

  do
    local get_execute_command =
      request('!.mechs.cmdline.get_cmd_execute_with_redirects')
    local file_to_str = request('!.convert.file_to_str')
    local os_tmpname = os.tmpname
    local os_execute = os.execute
    local os_remove = os.remove

    execute_shell_command =
      function(command)
        local output_filename = os_tmpname()
        local error_filename = os_tmpname()

        local shell_command =
          get_execute_command(command, output_filename, error_filename)

        local _, result_type_code, result_code = os_execute(shell_command)

        local Result = { }

        Result.is_aborted = get_is_aborted(result_type_code)
        Result.result_code = result_code
        Result.output = file_to_str(output_filename)
        Result.error = file_to_str(error_filename)

        os_remove(output_filename)
        os_remove(error_filename)

        local is_ok = (Result.result_code == 0)

        return is_ok, Result
      end
  end
end

-- Export:
return execute_shell_command

--[[
  2026-04-17
  2026-06-18
]]
