-- Anonymize pixel to structure

-- Last mod.: 2024-11-03

-- Exports:
return
  function(self, Pixel)
    local RedIs = self:CompileColorComponent(Pixel.Red)
    local GreenIs = self:CompileColorComponent(Pixel.Green)
    local BlueIs = self:CompileColorComponent(Pixel.Blue)

    if not (RedIs and GreenIs and BlueIs) then
      return
    end

    return { RedIs, GreenIs, BlueIs }
  end

--[[
  2024-11-03
]]
