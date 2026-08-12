-- Delete file given by pathname

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local file_exists = request('exists')
local get_rmfile_command = request('!.mechs.cmdline.get_cmd_rmfile')

--[[
  Delete file by pathname

  Returns true if file does not exist before or after execution.
]]
local remove_file =
  function(pathname)
    assert_string(pathname)

    if not file_exists(pathname) then return true end

    get_rmfile_command(pathname):Execute()

    if not file_exists(pathname) then return true end

    return false
  end

-- Export:
return remove_file

--[[
  2024
  2026 #
]]
