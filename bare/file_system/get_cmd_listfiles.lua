--[[
  Return shell command to list all files (not directories)
  in given directory.

  GNU/Bash assumed.
]]

return
  function(dir_name)
    return ('find %s -maxdepth 1 -type f'):format(dir_name)
  end
