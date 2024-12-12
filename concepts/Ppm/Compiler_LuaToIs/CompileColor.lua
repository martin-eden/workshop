-- Anonymize color to list

-- Last mod.: 2024-12-12

-- Imports:
local DenormalizeColor = request('!.concepts.Image.Color.Denormalize')

-- Exports:
return
  function(self, Color)
    DenormalizeColor(Color)

    local RedIs = self:CompileColorComponent(Color[1])
    local GreenIs = self:CompileColorComponent(Color[2])
    local BlueIs = self:CompileColorComponent(Color[3])

    if not (RedIs and GreenIs and BlueIs) then
      return
    end

    return { RedIs, GreenIs, BlueIs }
  end

--[[
  2024-11-03
  2024-11-25
  2021-12-12
]]
