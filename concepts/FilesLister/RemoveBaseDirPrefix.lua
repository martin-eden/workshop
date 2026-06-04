-- Remove base directory prefix from list of pathnames

--[[
  Author: Martin Eden
  Last mod.: 2026-06-04
]]

-- Imports:
local remove_prefix = request('!.string.remove_prefix')

local RemoveBaseDirPrefix =
  function(Me, FileNames)
    local base_dir = Me.BaseDir

    for i = 1, #FileNames do
      FileNames[i] = remove_prefix(FileNames[i], base_dir)
    end

    for i = #FileNames, 1, -1 do
      if (FileNames[i] == '') then
        table.remove(FileNames, i)
      end
    end
  end

-- Export:
return RemoveBaseDirPrefix

--[[
  2026-04-22
  2026-06-04
]]
