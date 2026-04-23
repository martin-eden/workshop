-- Return true if string ends with given string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')

-- Return true if string ends with given string. No magic characters!
local ends_with =
  function(base_str, postfix_str)
    local postfix_pattern = quote_regexp(postfix_str) .. '$'

    local start_pos = string.find(base_str, postfix_pattern)

    local result = is_number(start_pos)

    return result
  end

-- Export:
return ends_with

--[[
  2026-04-23
]]
