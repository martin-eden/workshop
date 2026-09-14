-- Open file for reading

--[[
  Author: Martin Eden
  Last mod.: 2026-09-14
]]

--[[
  If there is error opening file -- explodes. Else returns file object.
]]

local open_file = request('open')

-- Export:
return
  function(pathname)
    return open_file(pathname, 'rb')
  end

--[[
  2024 #
  2026 # #
]]
