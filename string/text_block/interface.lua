--[[
  This is interface for block of several text lines. Like

    "local k = 1"
    "for i = 1, n do"
    "  k = k * i"
    "end"
    ""
    "print(k)"

  This class will export next operations for such blocks:

    lines[] -- read-only
    add_line(s)
    add_text(s) -- text to concat to last line

  Intention is to store representations of formatted code and
  indent blocks.
]]

return
  {
    init = request('init'),

    lines = {}, -- read-only

    add_line = request('add_line'),
    add_text = request('add_text'),
  }
