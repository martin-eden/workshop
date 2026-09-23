-- Return list of directory names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local get_cmd_listdirs = request('!.mechs.cmdline.get_cmd_listdirs')
local get_command_output_lines = request('!.system.get_command_output_lines')
local to_clean_filelist = request('to_clean_filelist')

return
  function(base_dir)
    return
      to_clean_filelist(
        get_command_output_lines(get_cmd_listdirs(base_dir)),
        base_dir
      )
  end

--[[
  2017 #
  2026 # #
  2026-09-23
]]
