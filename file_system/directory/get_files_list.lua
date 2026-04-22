-- Return list of file names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local get_cmd_listfiles = request('!.mechs.cmdline.get_cmd_listfiles')
local get_program_output_lines = request('!.system.get_program_output_lines')

--[[
  Return file names in base directory as list of strings

  Each entry will contain base directory prefix.
]]
local get_files_list =
  function(base_dir)
    local cmd_get_files = get_cmd_listfiles(base_dir)

    local Result = get_program_output_lines(cmd_get_files)

    return Result
  end

-- Export:
return get_files_list

--[[
  2018-02-05
  2026-04-22
]]
