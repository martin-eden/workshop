-- Compile pixels to anonymous structure

-- Last mod.: 2024-11-25

-- Exports:
return
  function(self, Image)
    local MatrixIs = {}

    for RowIndex, Row in ipairs(Image) do
      MatrixIs[RowIndex] = {}

      for ColumnIndex, Color in ipairs(Row) do
        if not Color then
          return
        end

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
  2024-11-03
  2024-11-25
]]
