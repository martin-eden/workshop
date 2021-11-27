--[[
  Normalize coordinate.

  Next element past end of segment is first element.

  Core function. No checks.
]]

return
  function(coord, start, len)
    return start + ((coord - start) % len)
  end
