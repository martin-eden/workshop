-- Open file for reading

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

--[[
  If there is error opening file -- returns nil.
  Else returns file object.
]]

local open_for_reading =
  function(pathname)
    return ( io.open(pathname, 'rb') )
  end

-- Export:
return open_for_reading

--[[
  2024-08-09
  2026-05-27
]]
