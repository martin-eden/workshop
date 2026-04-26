-- Return true if string ends with given string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')

--[[
  Returns true if string ends with given string

  Magic characters are quoted.
]]
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
