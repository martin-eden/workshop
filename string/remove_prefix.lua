-- Remove prefix from string

--[[
  Author: Martin Eden
  Last mod.: 2026-04-22
]]

-- Imports:
local quote_regexp = request('!.lua.regexp.quote')

--[[
  Remove possible prefix string from string
]]
local remove_prefix =
  function(base_str, prefix_str)
    local prefix_regexp = '^' .. quote_regexp(prefix_str)
    local result = string.gsub(base_str, prefix_regexp, '')
    return result
  end

-- Export:
return remove_prefix

--[[
  2026-04-22
]]
