-- Characters and their ASCII codes used in Lua quoting

--[[
  Author: Martin Eden
  Last mod.: 2026-08-07
]]

local QuoteChars
do
  local AsciiCodes = request('!.concepts.Ascii.Codes')
  local AsciiChars = request('!.concepts.Ascii.Chars')

  QuoteChars =
    {
      single_quote_code = AsciiCodes.single_quote,
      double_quote_code = AsciiCodes.double_quote,
      backslash_code = AsciiCodes.backslash,

      single_quote = AsciiChars.single_quote,
      double_quote = AsciiChars.double_quote,
      backslash = AsciiChars.backslash,
    }
end

-- Export:
return QuoteChars

--[[
  2026-07-12
]]
