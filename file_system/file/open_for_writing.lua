-- Open file for writing

--[[
  Author: Martin Eden
  Last mod.: 2026-07-23
]]

--[[
  If there is error opening file -- explodes. Else returns file object.
]]

-- Imports:
local open_file = request('open')

local open_for_writing =
  function(pathname)
    return open_file(pathname, 'w+b')
  end

-- Export:
return open_for_writing

--[[
  2024-08-09
  2026-05-27
  2026-07-23
]]
