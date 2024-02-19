-- Change current directory.

--[[
  Return true if after execution current directory is what was asked.

  DOES NOT WORK (at least on my Linux machine)

  os.execute() spawns child process and changes directory for it,
  not for parent.
]]

-- Last mod.: 2024-02-19

local Get_ChDir_OsCommand = request('!.mechs.cmdline.get_cmd_chdir')
local GetCurrentDir = request('get_current')

return
  function(Path)
    assert_string(Path)

    local CurrentDir

    CurrentDir = GetCurrentDir()
    if (CurrentDir == Path) then
      return true
    end

    local ChDir_OsCommand = Get_ChDir_OsCommand(Path)
    os.execute(ChDir_OsCommand)

    CurrentDir = GetCurrentDir()
    if (CurrentDir == Path) then
      return true
    end

    return false
  end
