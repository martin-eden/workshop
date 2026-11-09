-- Unquote Lua string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local unquote_linear = request('unquote_string.linear')

local get_long_quote_len
do
  local long_quote_start = '^%[=*%['
  local str_match = string.match
  get_long_quote_len =
    function(str)
      return #str_match(str, long_quote_start)
    end
end

local str_sub = string.sub

return
  function(str)
    local result

    local first_char = str_sub(str, 1, 1)
    if (first_char == "'") or (first_char == '"') then
      result = str_sub(str, 2, -2)
      result = unquote_linear(result)
    elseif (first_char == '[') then
      local quote_len = get_long_quote_len(str)
      result = str_sub(str, quote_len + 1, -(quote_len + 1))
      -- Special case with long quotes. Heading newline is dropped.
      if (str_sub(result, 1, 2) == '\x0d\x0a') then
        result = str_sub(result, 3)
      elseif (str_sub(result, 1, 1) == '\x0a') then
        result = str_sub(result, 2)
      end
    end

    return result
  end

--[[
  2018
  2026-06-17
]]
