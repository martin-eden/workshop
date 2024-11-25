-- Compile pixels to anonymous structure

-- Last mod.: 2024-11-25

-- Exports:
return
  function(self, Image)
    local ColorIs = {}

    for RowIndex, Row in ipairs(Image.Lines) do
      local RowIs = {}

      for ColumnIndex, Color in ipairs(Row.Colors) do
        if not Color then
          return
        end

        local PixelIs = self:CompileColor(Color)

        if not PixelIs then
          return
        end

        table.insert(RowIs, PixelIs)
      end

      table.insert(ColorIs, RowIs)
    end

    return ColorIs
  end

--[[
  2024-11-03
]]
