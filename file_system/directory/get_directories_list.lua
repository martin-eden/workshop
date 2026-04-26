-- Return list of directory names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local get_cmd_listdirs = request('!.mechs.cmdline.get_cmd_listdirs')
local get_program_output_lines = request('!.system.get_program_output_lines')

--[[
  Return directory names in base directory as list of strings

  Each list entry is string with directory name with
  following properties:

    * Starts with base directory prefix
    * Does not contain "/"
]]
local get_dirs_list =
  function(base_dir)
    local cmd_get_dirs = get_cmd_listdirs(base_dir)

    local Dirs = get_program_output_lines(cmd_get_dirs)

    return Dirs
  end

-- Export:
return get_dirs_list

--[[
  2017-08-11
  2026-04-22
  2026-04-26
]]
