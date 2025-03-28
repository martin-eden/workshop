-- Load raw pixels data from .ppm stream

-- Last mod.: 2025-03-28

--[[
  Load pixels data from .ppm stream

  Requires parsed header to know dimensions of data.
  Data values are not processed. But grouped.

  In case there are not enough data returns nil.
  Else returns matrix of (height x width x num_color_components).
]]
local GetPixels =
  function(self, Header)
    local Data = {}

    for _ = 1, Header.Height do
      local Row = {}

      for _ = 1, Header.Width do
        local Color = self:GetChunk(self.NumColorComponents)

        if not Color then
          return
        end

        table.insert(Row, Color)
      end

      table.insert(Data, Row)
    end

    return Data
  end

-- Exports:
return GetPixels

--[[
  2024-11-03
  2025-03-28
]]
