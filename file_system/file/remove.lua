-- Delete file given by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local file_exists = request('exists')
local get_rmfile_command = request('!.mechs.cmdline.get_cmd_rmfile')

--[[
  Returns true if file does not exist before or after execution.
]]

-- Export:
return
  function(pathname)
    assert_string(pathname)

    if not file_exists(pathname) then return true end

    get_rmfile_command(pathname):Execute()

    if not file_exists(pathname) then return true end

    return false
  end

--[[
  2024 #
  2026 #
]]
