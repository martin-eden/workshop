-- Create directory by name. GNU/Bash.

--[[
  Returns true if directory is present at the end of execution
  and false in another case.
]]

--[[
  Version: 2
  Last mod.: 2024-02-17
]]

local DirectoryExists = request('exists')

local Get_CreateDir_OsCommand = request('!.mechs.cmdline.get_cmd_mkdir')

return
  function(DirectoryName)
    assert_string(DirectoryName)

    if DirectoryExists(DirectoryName) then
      return true
    end

    local CreateDir_OsCommand = Get_CreateDir_OsCommand(DirectoryName)
    os.execute(CreateDir_OsCommand)

    if DirectoryExists(DirectoryName) then
      return true
    end

    return false
  end
