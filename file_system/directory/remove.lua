-- Remove directory by name

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local directory_exists = request('exists')
local get_rmdir_command = request('!.mechs.cmdline.get_cmd_rmdir')
local shell_execute = request('!.concepts.shell.execute')

--[[
  Delete directory by pathname

  Returns true if directory does not exist before or after execution.
]]
local delete_dir =
  function(dir_name)
    assert_string(dir_name)

    if not directory_exists(dir_name) then return true end

    local rmdir_cmd = get_rmdir_command(dir_name)
    shell_execute(rmdir_cmd)

    if not directory_exists(dir_name) then return true end

    return false
  end

-- Export:
return delete_dir

--[[
  2024-02-17
  2026-04-22
]]
