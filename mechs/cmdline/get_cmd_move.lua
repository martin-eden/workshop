--[[
  Return shell command to move file to another name/location.

  GNU/bash assumed.
]]

-- Last mod.: 2024-10-21

return
  function(src_name, dest_name)
    return ('mv %q %q'):format(src_name, dest_name)
  end

--[[
  2018-02-05
  2024-10-21
]]
