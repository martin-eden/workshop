--[[
  Return shell command to move file to another name/location.

  GNU/bash assumed.
]]

return
  function(src_name, dest_name)
    return ('mv %s %s'):format(src_name, dest_name)
  end
