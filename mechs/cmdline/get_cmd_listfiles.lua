--[[
  Return shell command to list all files (not directories)
  in given directory.

  GNU/Bash assumed.
]]

-- Last mod.: 2024-10-21

return
  function(dir_name)
    return ('find %q -maxdepth 1 -type f'):format(dir_name)
  end

--[[
  2019-12-01
  2024-10-21
]]
