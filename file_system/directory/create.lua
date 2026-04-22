-- Create directory by name

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local directory_exists = request('exists')
local get_mkdir_command = request('!.mechs.cmdline.get_cmd_mkdir')
local shell_execute = request('!.concepts.shell.execute')

--[[
  Create directory by pathname

  Returns true if directory is present before or after execution.
]]
local creare_dir =
  function(dir_name)
    assert_string(dir_name)

    if directory_exists(dir_name) then return true end

    local mkdir_cmd = get_mkdir_command(dir_name)
    shell_execute(mkdir_cmd)

    if directory_exists(dir_name) then return true end

    return false
  end

-- Export:
return creare_dir

--[[
  2024-02-17
  2026-04-22
]]
