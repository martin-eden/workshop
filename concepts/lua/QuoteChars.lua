-- Characters and their ASCII codes used in Lua quoting

--[[
  Author: Martin Eden
  Last mod.: 2026-08-01
]]

local QuoteChars
do
  local Ascii = request('!.concepts.Ascii')
  QuoteChars =
    {
      newline_code = Ascii.Codes.newline,
      single_quote_code = Ascii.Codes.single_quote,
      double_quote_code = Ascii.Codes.double_quote,
      backslash_code = Ascii.Codes.backslash,

      newline = Ascii.Chars.newline,
      single_quote = Ascii.Chars.single_quote,
      double_quote = Ascii.Chars.double_quote,
      backslash = Ascii.Chars.backslash,
    }
end

-- Export:
return QuoteChars

--[[
  2026-07-12
]]
