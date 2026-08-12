-- Return list of directory names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

-- Imports:
local get_cmd_listdirs = request('!.mechs.cmdline.get_cmd_listdirs')
local get_command_output_lines = request('!.system.get_command_output_lines')

--[[
  Return directory names in base directory as list of strings

  Each list entry is string with directory name with
  following properties:

    * Starts with base directory prefix
    * Does not contain "/"
]]
local get_dirs_list =
  function(base_dir)
    return get_command_output_lines(get_cmd_listdirs(base_dir))
  end

-- Export:
return get_dirs_list

--[[
  2017 #
  2026 # #
]]
