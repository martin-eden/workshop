-- Remove directory if it does exist

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local directory_exists = request('exists')
local get_rmdir_command = request('!.mechs.cmdline.get_cmd_rmdir')

--[[
  Returns true if directory does not exist before or after execution.
]]

-- Export:
return
  function(dir_name)
    assert_string(dir_name)

    if not directory_exists(dir_name) then return true end

    get_rmdir_command(dir_name):Execute()

    if not directory_exists(dir_name) then return true end

    return false
  end

--[[
  2024 #
  2026 #
]]
