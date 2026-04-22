-- Return list of directory names in given directory

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local get_cmd_listdirs = request('!.mechs.cmdline.get_cmd_listdirs')
local get_program_output_lines = request('!.system.get_program_output_lines')
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')

--[[
  Return directory names in base directory as list of strings

  Each entry will contain base directory prefix.
  Each entry will end with directory separator "/".
]]
local get_dirs_list =
  function(base_dir)
    local cmd_get_files = get_cmd_listdirs(base_dir)

    local Dirs = get_program_output_lines(cmd_get_files)

    -- Add directory separator at end of entries
    for i = 1, #Dirs do
      Dirs[i] = add_dir_postfix(Dirs[i])
    end

    return Dirs
  end

-- Export:
return get_dirs_list

--[[
  2017-08-11
  2026-04-22
]]
