--[[
  Return shell command to copy file to another name/location.

  GNU/bash assumed.
]]

return
  function(src_name, dest_name)
    return ('cp %s %s'):format(src_name, dest_name)
  end
