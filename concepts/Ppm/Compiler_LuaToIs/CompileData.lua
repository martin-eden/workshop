-- Compile pixels to anonymous structure

-- Last mod.: 2024-11-03

-- Exports:
return
  function(self, Ppm)
    local PixelsIs = {}

    for Row = 1, Ppm.Height do
      local RowIs = {}

      for Column = 1, Ppm.Width do
        local Pixel = Ppm.Pixels[Row][Column]

        if not Pixel then
          return
        end

        local PixelIs = self:CompilePixel(Pixel)

        if not PixelIs then
          return
        end

        table.insert(RowIs, PixelIs)
      end

      table.insert(PixelsIs, RowIs)
    end

    return PixelsIs
  end

--[[
  2024-11-03
]]
