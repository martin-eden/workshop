-- Remove postfix from string

--[[
  Author: Martin Eden
  Last mod.: 2026-09-23
]]

local ends_with = request('ends_with')
local str_sub = string.sub

return
  function(base_str, postfix_str)
    if not ends_with(base_str, postfix_str) then return base_str end

    return str_sub(base_str, 1, -(#postfix_str + 1))
  end

--[[
  2026-09-23
]]
