-- Execute shell command

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

local <const> FileAsString = request('!.file_system.file.as_string')
local <const> GetCmd_ExecuteWithRedirects =
  request('!.mechs.cmdline.get_cmd_execute_with_redirects')

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

    local <const> Output = FileAsString(OutputFileName)
    local <const> Errors = FileAsString(ErrorsFileName)

    os.remove(OutputFileName)
    os.remove(ErrorsFileName)

    local <const> Result =
      {
        Output = Output,
        Errors = Errors,
      }

    if (ResultCodeType == 'exit') then
      Result.Code = ResultCode
    end
    if (ResultCodeType == 'signal') then
      Result.Signal = ResultCode
    end

    return Result
  end

-- Export:
return ExecuteShellCommand

--[[
  2026-04-17
]]
