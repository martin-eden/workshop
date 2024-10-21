-- Return shell command to delete directory. GNU/bash assumed.

-- Last mod.: 2024-10-21

return
  function(dir_name)
    return ('rm -r %q'):format(dir_name)
  end

--[[
  2018-12-08
  2024-02-17
  2024-10-21
]]
