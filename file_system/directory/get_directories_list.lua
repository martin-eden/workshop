-- Return list of directory names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local get_cmd_listdirs = request('!.mechs.cmdline.get_cmd_listdirs')
local get_command_output_lines = request('!.system.get_command_output_lines')

--[[
  Return directory names in base directory as list of strings

  Each list entry is string with directory name with
  following properties:

    * Starts with base directory prefix
    * Does not contain "/"
]]

-- Export:
return
  function(base_dir)
    return get_command_output_lines(get_cmd_listdirs(base_dir))
  end

--[[
  2017 #
  2026 # #
]]
