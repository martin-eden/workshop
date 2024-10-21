--[[
  Return shell command to create directory.

  GNU/bash assumed.
]]

-- Last mod.: 2024-10-21

return
  function(dir_name)
    return ('mkdir -p %q'):format(dir_name)
  end

--[[
  2018-02-05
  2024-10-21
]]
