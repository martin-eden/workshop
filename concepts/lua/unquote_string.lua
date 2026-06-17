-- Unquote Lua string

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local unquote_linear = request('unquote_string.linear')

local long_quote_start = '^%[=*%['
local long_quote_finish = '%]=*%]$'
local get_long_quote_len =
  function(s)
    local start_chunk = s:match(long_quote_start)
    local finish_chunk = s:match(long_quote_finish)
    local result
    if start_chunk and (#start_chunk == #finish_chunk) then
      result = #start_chunk
    end
    return result
  end

local unqote_string =
  function(s)
    local result

    local first_char = s:sub(1, 1)
    if (first_char == "'") or (first_char == '"') then
      result = s:sub(2, -2)
      result = unquote_linear(result)
    elseif (first_char == '[') then
      local quote_len = get_long_quote_len(s)
      if not quote_len then return end
      result = s:sub(quote_len + 1, -(quote_len + 1))
      -- Special case with long quotes. Heading newline is dropped.
      if (result:sub(1, 2) == '\x0d\x0a') then
        result = result:sub(3)
      elseif (result:sub(1, 1) == '\x0a') then
        result = result:sub(2)
      end
    end

    return result
  end

-- Export:
return unqote_string

--[[
  2018
  2026-06-17
]]
