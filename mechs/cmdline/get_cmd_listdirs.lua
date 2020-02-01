--[[
  Return shell command to list all directories in given directory.

  GNU/Bash assumed.
]]

return
  function(dir_name)
    return ('find %s -maxdepth 1 -type d'):format(dir_name)
  end
