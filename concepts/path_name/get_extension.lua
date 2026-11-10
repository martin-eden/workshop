-- Return extension for pathname string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-10
]]

local pathname_from_str = request('pathname_from_str')
local get_name = request('get_name')
local extension_regexp = '%.([^%.]+)$'
local str_match = string.match

return
  function(pathname_str)
    local filename = get_name(pathname_from_str(pathname_str))
    return str_match(filename, extension_regexp)
  end

--[[
  2026-11-10
]]
