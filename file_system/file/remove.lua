-- Delete file given by pathname

--[[
  Author: Martin Eden
  Last mod.: 2024-02-13
]]

-- Imports:
local file_exists = request('exists')
local get_rmfile_command = request('!.mechs.cmdline.get_cmd_rmfile')
local shell_execute = request('!.concepts.shell.execute')

--[[
  Delete file by pathname

  Returns true if file does not exist before or after execution.
]]
local remove_file =
  function(pathname)
    assert_string(pathname)

    if not file_exists(pathname) then return true end

    local remove_file_cmd = get_rmfile_command(pathname)
    shell_execute(remove_file_cmd)

    if not file_exists(pathname) then return true end

    return false
  end

-- Export:
return remove_file

--[[
  2024-02-13
  2026-04-22
]]
