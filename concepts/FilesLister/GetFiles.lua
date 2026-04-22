-- Return list of files

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local get_files_list = request('!.file_system.directory.get_files_list')

--[[
  Return file names in base directory as list of strings
]]
local GetFilesList =
  function(Me)
    local FileNames = get_files_list(Me.BaseDir)

    Me:RemoveBaseDirPrefix(FileNames)

    return FileNames
  end

-- Export:
return GetFilesList

--[[
  2017-08-11
  2026-04-22
]]
