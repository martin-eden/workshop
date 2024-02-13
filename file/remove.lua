-- Delete file given by pathname

--[[
  Returns true if file does not exist at end of execution. False otherwise.

  So post-condition is that given file does not exist. That is why
  we return true if it wasn't there at the start. Post-condition is
  satisfied.
]]

--[[
  Status: passed maiden flight
  Last mod.: 2024-02-13
]]

local Get_RemoveFile_Command = request('!.mechs.cmdline.get_cmd_rmfile')

local FileExists = request('exists')

return
  function(PathName)
    assert_string(PathName)

    -- File does not exist, job done:
    if not FileExists(PathName) then
      return true
    end

    local RemoveFile_Command = Get_RemoveFile_Command(PathName)
    local IsOk, ExitReason, ExitCode = os.execute(RemoveFile_Command)
    -- Something went wrong:
    if not IsOk then
      return false
    end

    return not FileExists(PathName)
  end
