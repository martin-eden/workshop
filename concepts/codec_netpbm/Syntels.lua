-- NetPBM syntax elements

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

-- Imports:
local AsciiChars = request('!.concepts.Ascii.Chars')

local Syntels =
  {
    space = AsciiChars.space,
    tab = AsciiChars.tab,
    newline = AsciiChars.newline,
    carriage_return = AsciiChars.carriage_return,
    comment_char = AsciiChars.number_sign,

    monochrome_label = 'P1',
    grayscale_label = 'P2',
    color_label = 'P3',
  }

-- Export:
return Syntels

--[[
  2026-08-08
]]
