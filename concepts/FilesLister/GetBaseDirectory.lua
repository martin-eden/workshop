-- Return Base Directory string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

--[[
  That's a design burden: caller can use SetBaseDirectory but to
  get base directory it has to read field "BaseDir".

  Caller should not remember this "BaseDir" name. It's for internal
  usage and can be changed.
]]

-- Get base directory
local GetBaseDir =
  function(Me)
    return Me.BaseDir
  end

-- Export:
return GetBaseDir

--[[
  2026-04-22
]]
