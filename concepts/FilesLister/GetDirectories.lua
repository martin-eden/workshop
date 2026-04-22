-- Return list of directories

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
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

    -- Remove entry with our base directory
    do
      for i = 1, #Dirs do
        -- Base directory name becomes empty string after prefix removal
        if (Dirs[i] == '') then
          table.remove(Dirs, i)
          break
        end
      end
    end

    return Dirs
  end

-- Export:
return GetDirectories

--[[
  2017-08-11
  2026-04-22
]]
