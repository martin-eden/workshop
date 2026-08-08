-- Add directory separator to end of string if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local Syntels = request('Syntels')
local ends_with = request('!.string.ends_with')

local sep = Syntels.separator

local add_separator =
  function(str)
    if ends_with(str, sep) then return str end

    return str .. sep
  end

return add_separator

--[[
  2018-02-05
  2026-06-16
]]
