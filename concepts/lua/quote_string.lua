-- Decision-making function how to represent data in Lua string syntax

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

local quote_escaped = request('quote_string.linear')
local quote_intact = request('quote_string.intact')
local quote_aggressive = request('quote_string.dump')

local content_funcs = request('!.string.content_attributes')
local has_control_chars = content_funcs.has_control_chars
local has_backslashes = content_funcs.has_backslashes
local has_single_quotes = content_funcs.has_single_quotes
local has_double_quotes = content_funcs.has_double_quotes
local has_newlines = content_funcs.has_newlines

local binary_entities_lengths =
  {
    [1] = true,
    [2] = true,
    [4] = true,
    [8] = true,
    [16] = true,
  }

return
  function(s)
    assert_string(s)

    local quote_func = quote_escaped

    if binary_entities_lengths[#s] and has_control_chars(s) then
      quote_func = quote_aggressive
    elseif
      has_backslashes(s) or
      has_newlines(s) or
      (has_single_quotes(s) and has_double_quotes(s))
    then
      quote_func = quote_intact
    end

    local result = quote_func(s)
    return result
  end

--[[
  2016-09
  2017-08
  2024-11
  2026-01-12
]]
