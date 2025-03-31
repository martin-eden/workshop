-- Anonymize parsed .ppm

-- Last mod.: 2025-03-29

--[[
  Compile Lua table with pixels to anonymous structure
]]
return
  function(self, Image)
    local MatrixIs = {}

    for RowIndex, Row in ipairs(Image) do
      MatrixIs[RowIndex] = {}

      for ColumnIndex, Color in ipairs(Row) do
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
]]
