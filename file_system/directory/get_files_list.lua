-- Return list of file names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local get_cmd_listfiles = request('!.mechs.cmdline.get_cmd_listfiles')
local get_command_output_lines = request('!.system.get_command_output_lines')
local to_clean_filelist = request('to_clean_filelist')

return
  function(base_dir)
    return
      to_clean_filelist(
        get_command_output_lines(get_cmd_listfiles(base_dir)),
        base_dir
      )
  end

--[[
  2018 #
  2026 #
  2026-09-23
]]
