-- Return file size in bytes

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

-- Imports:
local open_file = request('open')

local get_file_size =
  function(file_name)
    local File = open_file(file_name, 'rb')
    local result = File:seek('end')
    File:close()

    return result
  end

-- Export:
return get_file_size

--[[
  2016
  2017
  2026-05-30
]]
