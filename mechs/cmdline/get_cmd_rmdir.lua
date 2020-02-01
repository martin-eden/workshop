--[[
  Return shell command to delete directory.

  GNU/bash assumed.
]]

return
  function(dir_name)
    return ('rm -rf %s'):format(dir_name)
  end
