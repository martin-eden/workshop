-- Anonymize parsed .ppm

-- Last mod.: 2025-04-11

--[[
  Compile Lua table with pixels to anonymous structure
]]
return
  function(self, Image)
    local MatrixIs = {}

    for RowIndex = 1, Image.Height do
      local Row = Image[RowIndex] or {}

      MatrixIs[RowIndex] = {}

      for ColumnIndex = 1, Image.Width do
        local Color = Row[ColumnIndex] or {}

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
]]
