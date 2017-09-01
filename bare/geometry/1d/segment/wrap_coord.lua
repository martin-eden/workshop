--[[
  Normalize coordinate.

  Next element past end of segment is first element.

  Core function. No checks.
]]

return
  function(coord, start, len)
    coord = coord - start
    coord = coord % len
    coord = coord + start
    return coord
  end
