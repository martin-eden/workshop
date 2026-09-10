-- Check for file presence

--[[
  Author: Martin Eden
  Last mod.: 2026-09-10
]]

local get_cmd_file_exists = request('!.mechs.cmdline.get_cmd_file_exists')

-- Export:
return
  function(file_name)
    return (get_cmd_file_exists(file_name):Execute())
  end

--[[
  2016 #
  2026 # #
]]
