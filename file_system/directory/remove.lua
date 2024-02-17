-- Remove directory by name. GNU/Bash.

--[[
  Returns true if the directory does not exist after execution and
  false in another case.
]]

-- Last mod.: 2024-02-17

local DirectoryExists = request('exists')

local Get_RmDir_OsCommand = request('!.mechs.cmdline.get_cmd_rmdir')

return
  function(DirName)
    assert_string(DirName)

    if not DirectoryExists(DirName) then
      return true
    end

    local RmDir_OsCommand = Get_RmDir_OsCommand(DirName)
    os.execute(RmDir_OsCommand)

    if not DirectoryExists(DirName) then
      return true
    end

    return false
  end

