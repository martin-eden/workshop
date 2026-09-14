-- Return list of file names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

local get_cmd_listfiles = request('!.mechs.cmdline.get_cmd_listfiles')
local get_command_output_lines = request('!.system.get_command_output_lines')

--[[
  Return file names in base directory as list of strings

  Each entry will contain base directory prefix.
]]

-- Export:
return
  function(base_dir)
    return get_command_output_lines(get_cmd_listfiles(base_dir))
  end

--[[
  2018 #
  2026 #
]]
