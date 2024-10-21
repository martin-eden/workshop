-- Get GNU/Bash command to remove file by pathname

-- Last mod.: 2024-10-21

local CmdFormatStr = 'rm %q'

return
  function(PathName)
    assert_string(PathName)
    local Result = string.format(CmdFormatStr, PathName)
    return Result
  end

--[[
  2024-02-13
  2024-10-21
]]
