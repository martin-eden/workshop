-- Get GNU/Bash command to remove file by pathname

--[[
  Status: passed maiden flight
  Last mod.: 2024-02-13
]]

local CmdFormatStr = 'rm %q'

return
  function(PathName)
    assert_string(PathName)
    local Result = string.format(CmdFormatStr, PathName)
    return Result
  end
