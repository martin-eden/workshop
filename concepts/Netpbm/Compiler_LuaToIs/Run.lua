-- Anonymize parsed .ppm

--[[
  Author: Martin Eden
  Last mod.: 2026-01-13
]]

--[[
  Compile Lua table with pixels to anonymous structure
]]
return
  function(self, Image)
    local MatrixIs = {}
    local Width = Image.Settings.Width
    local Height = Image.Settings.Height

    for RowIndex = 1, Height do
      MatrixIs[RowIndex] = {}

      for ColumnIndex = 1, Width do
        local Color = Image:GetPixel({RowIndex, ColumnIndex})

        local ValueIs = self:CompileColor(Color)

        if not ValueIs then
          return
        end

        MatrixIs[RowIndex][ColumnIndex] = ValueIs
      end
    end

    return MatrixIs
  end

--[[
  2024-11 # # #
  2024-12-12
  2025-03-29
  2025-04-11
  2026-01-13
]]
