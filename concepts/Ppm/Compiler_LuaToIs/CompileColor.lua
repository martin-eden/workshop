-- Anonymize color to list

-- Last mod.: 2024-11-25

-- Exports:
return
  function(self, Color)
    local RedIs = self:CompileColorComponent(Color.Red)
    local GreenIs = self:CompileColorComponent(Color.Green)
    local BlueIs = self:CompileColorComponent(Color.Blue)

    if not (RedIs and GreenIs and BlueIs) then
      return
    end

    return { RedIs, GreenIs, BlueIs }
  end

--[[
  2024-11-03
]]
