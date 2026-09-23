-- Remove prefix from string

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local starts_with = request('starts_with')
local str_sub = string.sub

return
  function(base_str, prefix_str)
    if not starts_with(base_str, prefix_str) then return base_str end

    return str_sub(base_str, #prefix_str + 1)
  end

--[[
  2026 #
  2026-09-23
]]
