-- Execute shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

local <const> FileAsString = request('!.file_system.file.as_string')
local <const> GetCmd_ExecuteWithRedirects =
  request('!.mechs.cmdline.get_cmd_execute_with_redirects')

--[[
  Execute shell command and capture results

  Executes given string as shell (OS-dependent) command.
  Captures termination code / return code, output and errors.

  Output

    {
      ResultCode -- [int] Return code in case of normal ending
      TerminationCode -- [int] Termination code (signal number) in
        case of aborted ending
      Output -- [str] Program output
      Errors -- [str] Program errors
    }
]]
local <const> ExecuteShellCommand =
  function(Command)
    local <const> OutputFileName = os.tmpname()
    local <const> ErrorsFileName = os.tmpname()

    local <const> ShellCommand =
      GetCmd_ExecuteWithRedirects(
        Command, OutputFileName, ErrorsFileName
      )

    local <const> IsDone, ResultCodeType, ResultCode =
      os.execute(ShellCommand)

    local <const> Result = {}

    if (ResultCodeType == 'exit') then
      Result.ResultCode = ResultCode
    end
    if (ResultCodeType == 'signal') then
      Result.TerminationCode = ResultCode
    end

    Result.Output = FileAsString(OutputFileName)
    Result.Errors = FileAsString(ErrorsFileName)

    os.remove(OutputFileName)
    os.remove(ErrorsFileName)

    return Result
  end

-- Export:
return ExecuteShellCommand

--[[
  2026-04-17
]]
