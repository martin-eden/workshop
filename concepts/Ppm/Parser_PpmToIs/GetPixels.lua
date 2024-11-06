-- Load raw pixels data from .ppm stream

-- Last mod.: 2024-11-03

--[[
  Load pixels data from .ppm stream

  Requires parsed header to know dimensions of data.
  Data values are not processed. But grouped.

  In case there are not enough data, return nil.
  Else return matrix of (height x width x 3).
]]
local GetPixels =
  function(self, Header)
    local Data = {}

    for Row = 1, Header.Height do
      local RowData = {}

      for Column = 1, Header.Width do
        local NumColorComponents = 3
        local Color = self:GetChunk(NumColorComponents)

        if not Color then
          return
        end

        RowData[Column] = Color
      end

      Data[Row] = RowData
    end

    return Data
  end

-- Exports:
return GetPixels

--[[
  2024-11-03
]]
