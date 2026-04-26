-- Return true if string starts with given string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')

--[[
  Returns true if string starts with given string

  Magic characters are quoted.
]]
local starts_with =
  function(base_str, prefix_str)
    local prefix_pattern = '^' .. quote_regexp(prefix_str)

    local start_pos = string.find(base_str, prefix_pattern)

    local result = is_number(start_pos)

    return result
  end

-- Export:
return starts_with

--[[
  2026-04-23
]]
