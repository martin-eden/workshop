-- Characters and their ASCII codes used in Lua quoting

--[[
  Author: Martin Eden
  Last mod.: 2026-07-12
]]

local str_char = string.char

local newline_code = 10
local single_quote_code = 39
local double_quote_code = 34
local backslash_code = 92

local QuoteChars =
  {
    newline_code = newline_code,
    single_quote_code = single_quote_code,
    double_quote_code = double_quote_code,
    backslash_code = backslash_code,

    newline = str_char(newline_code),
    single_quote = str_char(single_quote_code),
    double_quote = str_char(double_quote_code),
    backslash = str_char(backslash_code),
  }

-- Export:
return QuoteChars

--[[
  2026-07-12
]]
