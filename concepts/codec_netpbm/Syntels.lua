-- NetPBM syntax elements

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local ascii_chars = request('!.concepts.ascii.chars')

return
  {
    space = ascii_chars.space,
    tab = ascii_chars.tab,
    newline = ascii_chars.newline,
    carriage_return = ascii_chars.carriage_return,
    comment_char = ascii_chars.number_sign,

    monochrome_label = 'P1',
    grayscale_label = 'P2',
    color_label = 'P3',
  }

--[[
  2026-08-08
]]
