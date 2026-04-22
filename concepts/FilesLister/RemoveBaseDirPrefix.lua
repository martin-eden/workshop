-- Remove base directory prefix from list of pathnames

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local remove_prefix = request('!.string.remove_prefix')

local RemoveBaseDirPrefix =
  function(Me, FileNames)
    for i = 1, #FileNames do
      FileNames[i] = remove_prefix(FileNames[i], Me.BaseDir)
    end
  end

-- Export:
return RemoveBaseDirPrefix
