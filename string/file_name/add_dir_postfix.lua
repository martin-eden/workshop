-- Add "/" to end of string if needed

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local ends_with = request('!.string.ends_with')

local add_dir_postfix =
  function(str)
    local dir_sep = '/'

    if ends_with(str, dir_sep) then return str end

    return str .. dir_sep
  end

return add_dir_postfix

--[[
  2018-02-05
  2026-06-16
]]
