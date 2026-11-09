-- Named available space characters for .dot format

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
  }

--[[
  2026 # #
]]
