-- Compile pixel to string

-- Last mod.: 2024-11-03

-- Exports:
return
  function(self, PixelIs)
    return
      string.format(
        self.PixelFmt,
        PixelIs[1],
        PixelIs[2],
        PixelIs[3]
      )
  end

--[[
  2024-11-03
]]
