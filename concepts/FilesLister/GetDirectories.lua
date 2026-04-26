-- Return list of directories

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local get_dirs_list = request('!.file_system.directory.get_directories_list')

--[[
  Return directory names in base directory as list of strings
]]
local GetDirectories =
  function(Me)
    local Dirs = get_dirs_list(Me.BaseDir)

    Me:RemoveBaseDirPrefix(Dirs)

    return Dirs
  end

-- Export:
return GetDirectories

--[[
  2017-08-11
  2026-04-22
]]
