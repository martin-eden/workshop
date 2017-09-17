--[[
  Return shell command to create directory.

  GNU/bash assumed.
]]

return
  function(dir_name)
    return ('mkdir -p %s'):format(dir_name)
  end
