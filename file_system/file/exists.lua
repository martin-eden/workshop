-- Check for file presence

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local get_cmd_file_exists = request('!.mechs.cmdline.get_cmd_file_exists')

return
  function(file_name)
    return (get_cmd_file_exists(file_name):execute())
  end

--[[
  2016 #
  2026 # #
]]
