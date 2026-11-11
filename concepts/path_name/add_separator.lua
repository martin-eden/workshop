-- Add directory separator to end of string if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

local sep = request('syntels').separator
local ends_with = request('!.string.ends_with')

return
  function(str)
    if ends_with(str, sep) then return str end
    return str .. sep
  end

--[[
  2018 #
  2026 #
]]
