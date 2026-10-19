-- Named syntax elements of .mmd format that we're using

--[[
  Author: Martin Eden
  Last mod.: 2026-09-15
]]

local AsciiChars = request('!.concepts.Ascii.Chars')

-- Export:
return
  {
    kw_flowchart = 'flowchart',
    topdown = 'TD',
    arrow = '-->',

    quote = AsciiChars.double_quote,
    end_statement = AsciiChars.newline,

    start_attr = AsciiChars.opening_bracket,
    end_attr = AsciiChars.closing_bracket,
  }

--[[
  2026-09-15
]]
