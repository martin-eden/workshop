-- Open file for reading

--[[
  Author: Martin Eden
  Last mod.: 2026-07-23
]]

--[[
  If there is error opening file -- explodes. Else returns file object.
]]

-- Imports:
local open_file = request('open')

local open_for_reading =
  function(pathname)
    return open_file(pathname, 'rb')
  end

-- Export:
return open_for_reading

--[[
  2024-08-09
  2026-05-27
  2026-07-23
]]
